resource "azurerm_kusto_cluster" "this" {
  name                = "${var.env}-adxcluster"
  location            = var.location
  resource_group_name = var.resource_group
  sku {
    name     = "Standard_D13_v2"
    capacity = 2
  }
  enable_streaming_ingest = true
}

resource "azurerm_kusto_database" "this" {
  name                = "${var.env}auditlogs"
  resource_group_name = var.resource_group
  location            = var.location
  cluster_name        = azurerm_kusto_cluster.this.name
  soft_delete_period  = "365d"
}

resource "azurerm_kusto_table" "audit_logs" {
  name        = "AuditLogs"
  resource_group_name = var.resource_group
  database_name       = azurerm_kusto_database.this.name
  cluster_name        = azurerm_kusto_cluster.this.name
  schema = <<SCHEMA
(
  Time: datetime,
  Source: string,
  User: string,
  Action: string,
  Details: string
)
SCHEMA
}

output "cluster_name" {
  value = azurerm_kusto_cluster.this.name
}

output "db_name" {
  value = azurerm_kusto_database.this.name
}