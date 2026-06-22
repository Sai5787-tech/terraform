output "nsg-id" {
    value = azurerm_network_security_group.nsg.id
}

output "nsg-association" {
  value = azurerm_subnet_network_security_group_association.nsg-assoc.id
}
