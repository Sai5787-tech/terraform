# Configure the Microsoft Azure Provider


resource "azurerm_resource_group" "newrg" {
  name = "sai-rg"
  location = "west us"
}

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

resource "azurerm_public_ip" "pip" {
  name                = "vm.pip"
  resource_group_name = azurerm_resource_group.newrg.name
  location            = azurerm_resource_group.newrg.location
  allocation_method   = "Static"

}

resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  location            = azurerm_resource_group.newrg.location
  resource_group_name = azurerm_resource_group.newrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}
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
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "linux-vm"
  resource_group_name = azurerm_resource_group.newrg.name
  location            = azurerm_resource_group.newrg.location
  size                = "Standard_D2s_v3"
  
  # Admin Username and Password
  admin_username      = "sai"
  admin_password      = "Password@123" 
  
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

  connection {
    user        = self.admin_username
    password    = self.admin_password
    host        = self.public_ip_address
  }

  provisioner "file" {
    source      = "nginx.sh"
    destination = "/home/sai/nginx.sh"
  }
  

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/sai/nginx.sh",
      "/home/sai/nginx.sh"
    ]
    
  }
}





