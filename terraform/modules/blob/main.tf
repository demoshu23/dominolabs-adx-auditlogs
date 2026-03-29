resource "azurerm_storage_account" "logs" {
  name                     = "${var.env}logs"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container1" {
  name                  = "container1"
  storage_account_name  = azurerm_storage_account.logs.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container2" {
  name                  = "container2"
  storage_account_name  = azurerm_storage_account.logs.name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "archive_policy" {
  storage_account_id = azurerm_storage_account.logs.id

  rule {
    name    = "archive-rule"
    enabled = true
    filters {
      prefix_match = ["container1/", "container2/"]
    }
    actions {
      base_blob {
        tier_to_archive_after_days_since_modification_greater_than = 365*30
      }
    }
  }
}

output "storage_account_name" {
  value = azurerm_storage_account.logs.name
}

output "storage_account_key" {
  value = azurerm_storage_account.logs.primary_access_key
}