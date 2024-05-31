#resource "confluence_content" "default" {
#  space = "KB"
#  title = "Azure VM Details: ${data.azurerm_virtual_machine.test.name}"
#  body = templatefile("${path.module}/azure_vm_template.tftpl", {
#    id                  = "example_id" // add the id here
#    vm_name             = data.azurerm_virtual_machine.test.name
#    resource_group_name = data.azurerm_virtual_machine.test.resource_group_name
#    location            = data.azurerm_virtual_machine.test.location
#    vm_size             = "10GB"
#    os_disk_name        = "Test"
#    os_type             = "Linux"
#    admin_username      = "admin"
#    network_interface_ids = [
#      "test"
#    ]
#    tags = {
#      tag1 = "value1"
#      tag2 = "value2"
#      // add more tags as needed
#    }
#  })
#  parent = "33172"
#}
