resource "azurerm_log_analytics_workspace" "n01537188-law" {
  name                = "n01537188-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"

  tags = var.common_tags
}

resource "azurerm_recovery_services_vault" "n01537188-rsv" {
  name                = "n01537188-rsv"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = var.common_tags
}

resource "azurerm_storage_account" "n01537188-sa" {
  name                     = "${var.storage_account_name}${random_integer.random_suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.common_tags
}

resource "random_integer" "random_suffix" {
  min = 1000
  max = 9999
  seed = var.storage_account_name
}
