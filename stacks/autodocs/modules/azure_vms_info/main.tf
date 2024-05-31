data "azapi_resource_list" "vms_by_resource_group" {
  type                   = "Microsoft.Compute/virtualMachines@2023-09-01"
  parent_id              = var.resource_group_id
  response_export_values = ["*"]
}

data "azurerm_virtual_machine" "vm_info" {
  for_each = local.vm_ids

  name                = each.value.name
  resource_group_name = var.resource_group_name
}

data "azurerm_network_interface" "vm_network_interface" {
  for_each            = local.network_interface_names
  name                = each.value.name
  resource_group_name = var.resource_group_name
}

locals {
  network_interface_ids = toset(distinct(flatten([
    for vm in data.azapi_resource_list.vms_by_resource_group.output.value :
    [for ni in vm.properties.networkProfile.networkInterfaces : ni.id]
  ])))

  network_interface_names = {
    for id in local.network_interface_ids : id => {
      name = element(split("/", id), length(split("/", id)) - 1)
    }
  }

  vm_ids = {
    for index, vm in data.azapi_resource_list.vms_by_resource_group.output.value : vm.id => {
      index = index
      name  = vm.name
      id    = vm.id
    }
  }

  vm_details = {
    for vm in data.azapi_resource_list.vms_by_resource_group.output.value : vm.id => {
      id                  = vm.id
      resource_group_name = var.resource_group_name
      location            = vm.location
      name                = vm.name
      power_state         = data.azurerm_virtual_machine.vm_info[vm.id].power_state
      vm_size             = vm.properties.hardwareProfile.vmSize


      hostname           = try(vm.properties.osProfile.computerName, "N/A")
      provisioning_state = vm.properties.provisioningState
      security_profile   = vm.properties.securityProfile
      os_type            = vm.properties.storageProfile.osDisk.osType
      os_image = {
        publisher     = vm.properties.storageProfile.imageReference.publisher
        offer         = vm.properties.storageProfile.imageReference.offer
        sku           = vm.properties.storageProfile.imageReference.sku
        version       = vm.properties.storageProfile.imageReference.version
        exact_version = try(vm.properties.storageProfile.imageReference.exactVersion, "N/A")
      }
      os_disk = {
        name            = vm.properties.storageProfile.osDisk.name
        caching         = vm.properties.storageProfile.osDisk.caching
        create_option   = vm.properties.storageProfile.osDisk.createOption
        disk_size_gb    = vm.properties.storageProfile.osDisk.diskSizeGB
        managed_disk_id = try(vm.properties.storageProfile.osDisk.managedDisk.id, "N/A")
        os_type         = vm.properties.storageProfile.osDisk.osType
      }
      disks = {
        for disk in vm.properties.storageProfile.dataDisks : disk.name => {
          name            = disk.name
          caching         = disk.caching
          create_option   = disk.createOption
          disk_size_gb    = disk.diskSizeGB
          managed_disk_id = try(disk.managedDisk.id, "N/A")
        }
      }

      private_ip_address   = data.azurerm_virtual_machine.vm_info[vm.id].private_ip_address
      public_ip_address    = data.azurerm_virtual_machine.vm_info[vm.id].public_ip_address
      private_ip_addresses = data.azurerm_virtual_machine.vm_info[vm.id].private_ip_addresses
      public_ip_addresses  = data.azurerm_virtual_machine.vm_info[vm.id].public_ip_addresses

      network_interface_id = vm.properties.networkProfile.networkInterfaces[0].id
      network_interfaces = [
        for ni in vm.properties.networkProfile.networkInterfaces :
        {
          id                        = ni.id
          network_security_group_id = data.azurerm_network_interface.vm_network_interface[ni.id].network_security_group_id

          ip_configurations = {
            for ip_config in data.azurerm_network_interface.vm_network_interface[ni.id].ip_configuration :
            ip_config.name => {
              name                                          = ip_config.name
              primary                                       = ip_config.primary
              private_ip_address                            = ip_config.private_ip_address
              public_ip_address_id                          = ip_config.public_ip_address_id
              subnet_id                                     = ip_config.subnet_id
              load_balancer_backend_address_pools_ids       = ip_config.load_balancer_backend_address_pools_ids
              application_gateway_backend_address_pools_ids = ip_config.application_gateway_backend_address_pools_ids
            }
          }

          mac_address         = data.azurerm_network_interface.vm_network_interface[ni.id].mac_address
          applied_dns_servers = data.azurerm_network_interface.vm_network_interface[ni.id].applied_dns_servers
          location            = data.azurerm_network_interface.vm_network_interface[ni.id].location
          subnet_id           = data.azurerm_network_interface.vm_network_interface[ni.id].ip_configuration[0].subnet_id
          private_ip_address  = data.azurerm_network_interface.vm_network_interface[ni.id].private_ip_address
        }
      ]

      tags = vm.tags
      type = vm.type
    }
  }
}
