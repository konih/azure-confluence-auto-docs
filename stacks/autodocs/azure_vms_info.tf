data "azurerm_resource_group" "vm_autodocs_demo" {
  name = "vm-autodocs-demo"
}

data "azurerm_resource_group" "vm_autodocs_demo_2" {
  name = "autodocs-demo-2-1_group"
}

data "azurerm_resource_group" "vm_autodocs_demo_3" {
  name = "windoofs_group"
}
module "azure_vms_info_autodocs_demo" {
  source = "./modules/azure_vms_info"
  resource_group_name = data.azurerm_resource_group.vm_autodocs_demo_3.name
  resource_group_id = data.azurerm_resource_group.vm_autodocs_demo_3.id
}