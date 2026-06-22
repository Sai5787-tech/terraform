resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg
  location            = var.location
  resource_group_name = var.rg-name

  security_rule {
    name                       = var.rule-name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.port-range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  subnet_id                 = var.subnet-id
  network_security_group_id = var.nsg-id
}