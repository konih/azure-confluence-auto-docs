variable "resource_group_names" {
  type        = list(string)
  default     = ["vm-autodocs-demo", "autodocs-demo-2-1_group", "windoofs_group"]
  description = "List of resource groups to get VM information from"
}

