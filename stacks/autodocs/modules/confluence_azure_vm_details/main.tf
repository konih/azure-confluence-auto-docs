locals {
  service_class_emojis = {
    "sandbox"    = "🏖️",
    "dev"        = "💻"
    "bronze"     = "🥉",
    "silver"     = "🥈",
    "gold"       = "🥇",
    "platinum"   = "💎",
    "production" = "🚀",
    "n/a"        = "❓",
  }
  service_class       = try(var.vm_details.tags["Service class"], try(var.vm_details.tags["Service Class"], "N/A"))
  service_class_emoji = lookup(local.service_class_emojis, lower(local.service_class), "🤷")

  network_interfaces_html = templatefile("${path.module}/network_interfaces.html", {
    network_interfaces = { for interface in var.vm_details.network_interfaces : interface.id => interface }
  })

  content = templatefile("${path.module}/azure_vm_template.html", {
    last_generated_date       = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
    include_table_of_contents = false
    vm                        = var.vm_details,
    network_interfaces_html   = local.network_interfaces_html
    service_class_emoji       = local.service_class_emoji,
    service_class             = local.service_class,
  })

}

output "templated_content" {
  value = local.content
}
