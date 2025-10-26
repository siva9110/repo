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
  address_space       = ["10.0.2.0/16"]
  location            = var.azurerm_location
  resource_group_name = var.azurerm_resource_group

}

resource "azurerm_subnet" "subnet-1" {
  name                 = "testingvsub"
  virtual_network_name = var.azurerm_virtual_network
  resource_group_name  = var.azurerm_resource_group
  address_prefixes     = ["10.0.0.1/24"]

}
