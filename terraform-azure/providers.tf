terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "microfostsitnamedtest1"
    storage_account_name = "storage123"
    container_name       = "containername"
    key                  = "terraform.containername"
  }
}

provider "azurerm" {
  features {}
}