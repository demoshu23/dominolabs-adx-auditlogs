resource "azurerm_function_app" "this" {
  name                       = "${var.env}-ingest-func"
  location                   = var.location
  resource_group_name        = var.resource_group
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_key
  version                    = "~4"
  os_type                    = "Linux"
  runtime_stack              = "PYTHON|3.11"
  site_config {
    app_settings = {
      "AZURE_STORAGE_CONNECTION_STRING" = var.storage_account_key
      "ADX_CLUSTER"                     = var.adx_cluster_name
      "ADX_DB"                          = var.adx_db_name
    }
  }
}

output "function_app_name" {
  value = azurerm_function_app.this.name
}