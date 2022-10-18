output "sqlservername" {
    value = azurerm_mssql_server.sqlserver.name
}
output "sqlserverid" {
    value = azurerm_mssql_server.sqlserver.id
}
output "sqlserverdbid" {
    value = azurerm_mssql_database.sqldb.id
}