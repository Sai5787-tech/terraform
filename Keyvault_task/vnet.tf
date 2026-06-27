resource "azurerm_virtual_network" "vnet" {
    name = "vnet01"
    location = azurerm_resource_group.newrg.location
    address_space = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.newrg.name

}

resource "azurerm_subnet" "subnet" {
name = "subnet1"
virtual_network_name = azurerm_virtual_network.vnet.name
resource_group_name = azurerm_resource_group.newrg.name
address_prefixes = ["10.0.1.0/24"]
}