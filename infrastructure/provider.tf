terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  backend "azurerm" {
    key = "desafio-devops"
  }
}

provider "azurerm" {
  features {}
}
