variable "vm_details" {
  description = "Details of the virtual machines"
  type        = object({
    id                  = string
    resource_group_name = string
    location            = string
    name                = string
    power_state         = string
    vm_size             = string
    hostname            = string
    provisioning_state  = string
    security_profile    = any
    os_type             = string
    os_image            = object({
      publisher     = string
      offer         = string
      sku           = string
      version       = string
      exact_version = optional(string)
    })
    os_disk = object({
      name            = string
      caching         = string
      create_option   = string
      disk_size_gb    = number
      managed_disk_id = string
      os_type         = string
    })
    disks = map(object({
      name            = string
      caching         = string
      create_option   = string
      disk_size_gb    = number
      managed_disk_id = string
    }))
    private_ip_address    = string
    public_ip_address     = string
    private_ip_addresses  = list(string)
    public_ip_addresses   = list(string)
    network_interface_id  = string
    network_interfaces = list(object({
      id                        = string
      network_security_group_id = string
      ip_configurations         = map(object({
        name                                          = string
        primary                                       = bool
        private_ip_address                            = string
        public_ip_address_id                          = string
        subnet_id                                     = string
        load_balancer_backend_address_pools_ids       = list(string)
        application_gateway_backend_address_pools_ids = list(string)
      }))
      mac_address         = string
      applied_dns_servers = list(string)
      location            = string
      subnet_id           = string
      private_ip_address  = string
    }))
    tags = map(string)
    type = string
  })
}