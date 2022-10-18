resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlservername
  resource_group_name          = var.rgname
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.login
  administrator_login_password = var.password
  minimum_tls_version          = "1.2"
  public_network_access_enabled = false
}
resource "azurerm_mssql_database" "sqldb" {
  name           = var.sqldbname
  server_id      = azurerm_mssql_server.sqlserver.id
}