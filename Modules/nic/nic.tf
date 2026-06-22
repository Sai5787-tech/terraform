resource "azurerm_network_interface" "nic" {
  name                = var.nic
  location            = var.loc
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet-id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.pip-id
  }
}