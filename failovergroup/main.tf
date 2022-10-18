resource "azurerm_mssql_server" "secondary" {
  name                         = "${var.sqlservername}-secondary"
  resource_group_name          = var.rgname
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.secondarylogin
  administrator_login_password = var.secondarypassword
}
resource "azurerm_mssql_failover_group" "example" {
  name      = "${var.sqlservername}-failovergroup"
  server_id = var.primarysqlserverid
  databases = [
    var.primarysqldbid
  ]

  partner_server {
    id = azurerm_mssql_server.secondary.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }
}