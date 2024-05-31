locals {
  resource_groups = toset(var.resource_group_names)
  all_vms_list = flatten([
    for key, output in module.azure_vms_info_autodocs_demo :
    [
      for key, vm in output.vms_details :
      vm
    ]
  ])
  all_vms_details = {
    for vm in local.all_vms_list :
    vm.id => vm
  }
}

data "azurerm_resource_group" "resource_groups" {
  for_each = local.resource_groups

  name = each.key
}

module "azure_vms_info_autodocs_demo" {
  for_each = data.azurerm_resource_group.resource_groups
  source   = "./modules/azure_vms_info"

  resource_group_name = data.azurerm_resource_group.resource_groups[each.key].name
  resource_group_id   = data.azurerm_resource_group.resource_groups[each.key].id
}


module "confluence_azure_vm_details" {
  source   = "./modules/confluence_azure_vm_details"
  for_each = local.all_vms_details

  vm_details = each.value
}

resource "confluence_content" "default" {
  for_each = local.all_vms_details
  space    = "KB"
  title    = "${each.value.name} - ${each.value.resource_group_name} - Vm Details"
  body     = module.confluence_azure_vm_details[each.key].templated_content
  parent   = "33172"
}
