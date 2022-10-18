resource "azurerm_windows_web_app" "example" {
  name                = "${var.apiappname}"
  resource_group_name = var.rgname
  location            = var.location
  service_plan_id     = var.aspid
  site_config {}
}
# resource "azurerm_linux_web_app" "example" {
#   count  = (var.ostype == "Linux") ? 1 : 0
#   name                = "${var.apiappname}"
#   resource_group_name = var.rgname
#   location            = var.location
#   service_plan_id     = var.linuxaspid
#   site_config {}
# }