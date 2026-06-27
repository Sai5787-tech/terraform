provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  subscription_id = ""
}

data "azurerm_client_config" "exist" {
  
}
