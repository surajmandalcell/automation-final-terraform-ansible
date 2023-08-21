# Common
variable "common_tags" {
  type        = map(string)
  description = "This block is to define common tags"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

# This
variable "humber_id" {
  description = "Humber ID for uniqueness in resource naming"
  type        = string
}


variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the PostgreSQL server"
  type        = string
}

variable "postgresql_version" {
  description = "PostgreSQL version for the server"
  type        = string
}

variable "administrator_login_password" {
  description = "Password for the PostgreSQL server"
  type        = string
}