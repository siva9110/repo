provider "azurerm" {
  features {}

  client_id                       = var.client_id
  client_secret                   = var.client_secret
  tenant_id                       = var.tenant_id
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"

}


terraform {
  backend "azurerm" {
    storage_account_name = "exam9110398"
    container_name       = "testcont"
    key                  = "terraform.tfstate"
    access_key           = "7e8AX0DtDmPRUWAzYRv8AGNuUEMaj7bmMvgnOjXiND/LnsOC4jNT9TtJtE/zHtFO+XGx7FUDbQzA+AStzLSYng=="

  }
}


resource "azurerm_virtual_network" "v-net" {
  name                = var.azurerm_virtual_network
  address_space       = ["10.0.0.0/16"]
  location            = var.azurerm_location
  resource_group_name = var.azurerm_resource_group

}

resource "azurerm_subnet" "subnet-1" {
  name                 = "testingvsub"
  virtual_network_name = var.azurerm_virtual_network
  resource_group_name  = var.azurerm_resource_group
  address_prefixes     = ["10.0.0.0/24"]
  depends_on           = [azurerm_virtual_network.v-net]

}


resource "azurerm_subnet" "siva" {
  name                 = "sivasubnetfordevops"
  virtual_network_name = var.azurerm_virtual_network
  resource_group_name  = var.azurerm_resource_group
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [azurerm_virtual_network.v-net]

}

resource "azurerm_storage_account" "storage" {
  name                     = "kcufsunny"
  location                 = "West US"
  resource_group_name      = var.azurerm_resource_group
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}



resource "azurerm_network_interface" "nic" {
  name                = "winvm-nic"
  location            = var.azurerm_location
  resource_group_name = var.azurerm_resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.siva.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "winvm-basic"
  resource_group_name = var.azurerm_resource_group
  location            = var.azurerm_location
  size                = "Standard_B1s" # very basic VM size
  admin_username      = "adminuser"
  admin_password      = "P@ssword1234!" # Use secrets in production

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = {
    environment = "sandbox"
  }
}




resource "azurerm_network_interface" "nic-1" {
  name                = "winvm-nic-1"
  location            = var.azurerm_location
  resource_group_name = var.azurerm_resource_group

  ip_configuration {
    name                          = "internal-1"
    subnet_id                     = azurerm_subnet.siva.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm-1" {
  name                = "winvm-basic-1"
  resource_group_name = var.azurerm_resource_group
  location            = var.azurerm_location
  size                = "Standard_B1s" # very basic VM size
  admin_username      = "adminuser"
  admin_password      = "P@ssword1234!" # Use secrets in production

  network_interface_ids = [
    azurerm_network_interface.nic-1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = {
    environment = "sandbox"
  }
}





