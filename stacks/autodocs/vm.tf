data "azurerm_virtual_machine" "test" {
  name                = "vm-autodocs-demo"
  resource_group_name = "vm-autodocs-demo"
}

data "azurerm_resource_group" "example" {
  name = "vm-autodocs-demo"
}

data "azapi_resource" "example" {
  name        = data.azurerm_virtual_machine.test.name
  parent_id   = data.azurerm_resource_group.example.id
  resource_id = data.azurerm_virtual_machine.test.id
  type        = "Microsoft.Compute/virtualMachines@2023-09-01"
}

data "azapi_resource_list" "listByResourceGroup" {
  type                   = "Microsoft.Compute/virtualMachines@2023-09-01"
  parent_id              = data.azurerm_resource_group.example.id
  response_export_values = ["*"]
}

output "test" {
  value = data.azapi_resource_list.listByResourceGroup[*]
}
