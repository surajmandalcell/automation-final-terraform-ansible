resource "azurerm_postgresql_server" "database_instance" {
  name                         = "database-${var.humber_id}"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku_name                     = var.sku_name
  version                      = var.postgresql_version
  administrator_login          = "n01537188"
  administrator_login_password = var.administrator_login_password
  ssl_enforcement_enabled      = true
}
