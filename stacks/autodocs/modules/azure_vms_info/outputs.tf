output "vms_details" {
  value = local.vm_details
}

output "vms_by_resource_group_raw_output" {
  value = data.azapi_resource_list.vms_by_resource_group
}
