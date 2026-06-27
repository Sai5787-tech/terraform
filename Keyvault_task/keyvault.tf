data "azurerm_key_vault" "vault" {
  name                = "saikey57878"
  resource_group_name = azurerm_resource_group.newrg.name
}

output "vault_uri" {
  value = data.azurerm_key_vault.vault.id
}

data "azurerm_key_vault_secret" "user1" {
    name = "saiadmin"
    key_vault_id = data.azurerm_key_vault.vault.id
  
}
output "secret_value" {
  value     = data.azurerm_key_vault_secret.user1.id
  sensitive = true
}

data "azurerm_key_vault_secret" "user1-password" {
    name = "password"
    key_vault_id = data.azurerm_key_vault.vault.id
  
}
output "secret_value_pass" {
  value     = data.azurerm_key_vault_secret.user1-password.id
}




