provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
  client_id       = "useyourclientid_her"
  client_secret   = "useyourclientsecret_here"
  tenant_id       = "useyourtenantid_here"
  subscription_id = "useyoursubid_here"
}

module "rg" {
  source = "../Modules/Rg-module"
  rg-name = "sai-rg01"
  location = "West US"
}

module "vnet" {
  source = "../Modules/vnet"
  vnet-name = "vnet1"
  ipaddress = ["10.0.0.0/16"]
  sub-name = "subnet1"
  sub-ip = ["10.0.1.0/24"]
  rg-name = module.rg.resorce_group_name
  location = module.rg.resource_group_location
}

module "pip"{
source = "../Modules/pip"
pip = "vm-pip"
rg_name = module.rg.resorce_group_name
loc = module.rg.resource_group_location
}

module "nic" {
  source = "../Modules/nic"
  nic = "vm-nic"
  loc = module.rg.resource_group_location
  rg_name = module.rg.resorce_group_name
  subnet-id = module.vnet.subnet_id
  pip-id = module.pip.public_ip_id
}

module "nsg" {
  source = "../Modules/nsg"
  nsg = "sai-nsg"
  location = module.rg.resource_group_location
  rg-name = module.rg.resorce_group_name
  rule-name = "sai-rule"
  port-range = "22"
  subnet-id = module.vnet.subnet_id
  nsg-id = module.nsg.nsg-id
}

module "sai-vm" {
  source = "../Modules/virtual_machine"
  vm-name = "Linux-vm"
  rg_name = module.rg.resorce_group_name
  location = module.rg.resource_group_location
  size = "Standard_D2s_v3"
  admin_user = "azadmin"
  admin_pass = "Password@123"
  nic-id = module.nic.nic-ip
  ReadWrite = "ReadWrite"
  Standard_LRS = "Standard_LRS"
  Canonical = "Canonical"
  UbuntuServer = "0001-com-ubuntu-server-jammy"
}




