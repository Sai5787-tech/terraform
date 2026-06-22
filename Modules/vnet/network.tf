resource "azurerm_virtual_network" "vnet" {
    name = var.vnet-name
    location = var.location
    address_space = var.ipaddress
    resource_group_name = var.rg-name

}

resource "azurerm_subnet" "subnet" {
name = var.sub-name
virtual_network_name = azurerm_virtual_network.vnet.name
resource_group_name = var.rg-name
address_prefixes = var.sub-ip
}