resource "azurerm_service_plan" "kgs" {
  # count  = (var.ostype == "Windows") ? 1 : 0
  name                = "${var.aspname}-windows-appserviceplan"
  resource_group_name = var.rgname
  location            = var.location
  sku_name            = "S1"
  os_type             = var.ostype
}
# resource "azurerm_service_plan" "linux" {
#   count  = (var.ostype == "Linux") ? 1 : 0
#   name                = "${var.aspname}-linux-appserviceplan"
#   resource_group_name = var.rgname
#   location            = var.location
#   sku_name            = "S1"
#   os_type             = "Linux"
# }