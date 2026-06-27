resource "azurerm_public_ip" "pip" {
  name                = "vm.pip"
  resource_group_name = azurerm_resource_group.newrg.name
  location            = azurerm_resource_group.newrg.location
  allocation_method   = "Static"

}
