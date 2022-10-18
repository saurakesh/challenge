data "azurerm_resources" "web_apps_filter" {
  resource_group_name = var.rgname
  type                = "Microsoft.Web/sites"
  required_tags = {
    ProvisionedWith = "Terraform"
  }
}
data "azurerm_windows_web_app" "web_apps" {
  count = length(data.azurerm_resources.web_apps_filter.resources)

  resource_group_name = var.rgname
  name                = data.azurerm_resources.web_apps_filter.resources[count.index].name
}
locals {
  # flatten ensures that this local value is a flat list of IPs, rather
  # than a list of IPs.
  # distinct ensures that we have only uniq IPs

  web_ips = distinct(flatten([
    for app in data.azurerm_windows_web_app.web_apps : [
      split(",", app.possible_outbound_ip_addresses)
    ]
  ]))
}
resource "azurerm_mssql_firewall_rule" "apptier" {
  for_each = toset(local.web_ips)

  name                = "web_app_ip_${replace(each.value, ".", "_")}"
  server_id           = var.sqlserverid
  start_ip_address    = each.value
  end_ip_address      = each.value
}