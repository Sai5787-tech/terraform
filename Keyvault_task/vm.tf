resource "azurerm_linux_virtual_machine" "vm" {
  name                = "linux-vm"
  resource_group_name = azurerm_resource_group.newrg.name
  location            = azurerm_resource_group.newrg.location
  size                = "Standard_D2s_v3"
  
  # Admin Username and Password
  admin_username      = data.azurerm_key_vault_secret.user1.value
  admin_password      = data.azurerm_key_vault_secret.user1-password.value
  
  # Disable SSH key authentication to use the password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
