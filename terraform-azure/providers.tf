terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "testname0123456789"
    storage_account_name = "storageaccounttest1234"
    container_name       = "containernameisamazing"
    key                  = "terraform.containernameisamazing"
  }
}

provider "azurerm" {
  features {}
}

