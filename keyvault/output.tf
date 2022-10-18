output "username" {
    value = azurerm_key_vault_secret.sqlusername.value
}
output "userpwd" {
    value = azurerm_key_vault_secret.sqlpassword.value
}