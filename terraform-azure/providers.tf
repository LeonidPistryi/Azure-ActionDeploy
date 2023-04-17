terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rsgroupwpteam"
    storage_account_name = "storagewpteam"
    container_name       = "wpteamcontainer"
    key                  = "terraform.wpteamcontainer"
  }
}

provider "azurerm" {
  features {}
}