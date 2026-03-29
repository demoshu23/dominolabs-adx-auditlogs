provider "azurerm" {
  features {}
}

variable "env" {}
variable "location" {}
variable "resource_group" {}
variable "app_service_plan_id" {}

# Modules
module "blob" {
  source         = "./modules/blob"
  env            = var.env
  location       = var.location
  resource_group = var.resource_group
}

module "adx" {
  source         = "./modules/adx"
  env            = var.env
  location       = var.location
  resource_group = var.resource_group
}

module "function" {
  source                = "./modules/function"
  env                   = var.env
  location              = var.location
  resource_group        = var.resource_group
  app_service_plan_id   = var.app_service_plan_id
  storage_account_name  = module.blob.storage_account_name
  storage_account_key   = module.blob.storage_account_key
  adx_cluster_name      = module.adx.cluster_name
  adx_db_name           = module.adx.db_name
}