resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm-name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.size
  
  # Admin Username and Password
  admin_username      = var.admin_user
  admin_password      = var.admin_pass 
  
  # Disable SSH key authentication to use the password
  disable_password_authentication = false

  network_interface_ids = [
    var.nic-id,
  ]

  os_disk {
    caching              = var.ReadWrite
    storage_account_type = var.Standard_LRS
  }

  source_image_reference {
    publisher = var.Canonical
    offer     = var.UbuntuServer
    sku       = "22_04-lts"
    version   = "latest"
  }
}