resource "random_string" "username" {
  length = 10
  special = false
}

resource "random_password" "password" {
  length = 24
  special = true
}
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
  name                        = var.kvname
  location                    = var.location
  resource_group_name         = var.rgname
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  sku_name = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]
  }
}
resource "azurerm_key_vault_secret" "sqlusername" {
  name         = "sql-username"
  value        = random_string.username.result
  key_vault_id = azurerm_key_vault.keyvault.id
  depends_on = [azurerm_key_vault.keyvault]
}

resource "azurerm_key_vault_secret" "sqlpassword" {
  name         = "sql-password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.keyvault.id
  depends_on = [azurerm_key_vault_secret.sqlusername]
}