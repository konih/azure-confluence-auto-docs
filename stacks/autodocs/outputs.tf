output "azure_vm_info_raw_output" {
  value = module.azure_vms_info_autodocs_demo.vms_by_resource_group_raw_output
}

output "vm_details" {
  value = module.azure_vms_info_autodocs_demo.vm_details
}