provider "azurerm" {
  features {}

  client_id                       = var.client_id
  client_secret                   = var.client_secret
  tenant_id                       = var.tenant_id
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"

}

resource "azurerm_virtual_network" "v-net" {
  name                = var.azurerm_virtual_network
  address_space       = ["10.0.0.0/16"]
  location            = var.azurerm_location
  resource_group_name = var.azurerm_resource_group

}



resource "azurerm_storage_account" "storage" {
  name                     = "exam9110398"
  resource_group_name      = var.azurerm_resource_group
  location                 = var.azurerm_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Terraform"
  }
}


resource "azurerm_subnet" "subnet-1" {
  name = "testing-prodsubnet"
  virtual_network_name = var.azurerm_virtual_network
  resource_group_name = var.azurerm_resource_group
  address_prefixes = [ "10.0.0.7/24" ]
  
}
