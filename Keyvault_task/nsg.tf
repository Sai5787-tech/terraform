resource "azurerm_network_security_group" "nsg" {
  name                = "sai-nsg"
  location            = azurerm_resource_group.newrg.location
  resource_group_name = azurerm_resource_group.newrg.name

  security_rule {
    name                       = "sai-rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
