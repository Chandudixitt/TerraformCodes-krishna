terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.61.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "evtz-eu-rgtf"
      storage_account_name = "evtzeustractf"
      container_name       = "evtz-eu-cntfstate"
  }
}

provider "azurerm" {
  features {}
# subscription_id = "c02a16cc-c49a-49c4-ab3c-ced2938ef462"
# tenant_id = "e7ca1d1b-0b74-449f-8cc2-a9865bfc0a5f"
# client_id = "ab316ad2-1b4d-4c4c-9e77-766ae86ab9da"

}
provider "azuread" {
  
}

data "azurerm_client_config" "current" {
}