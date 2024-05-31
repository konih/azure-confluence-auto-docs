terraform {
  required_providers {
    confluence = {
      source  = "DrFaust92/confluence"
      version = "0.2.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "confluence" {
  site  = null
  user  = null
  token = null
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

provider "azapi" {
  enable_hcl_output_for_data_source = true
}
