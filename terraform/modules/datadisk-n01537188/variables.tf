# Common
variable "common_tags" {
  type        = map(string)
  description = "This block is to define common tags"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# This
variable "vmlinux-datadisk-info" {
  type        = any
  description = "Contians information about the datadisk for Linux VMs"
}

variable "vmlinux-datadisk-attachment-info" {
  type        = any
  description = "Contians information about attachment configurations for Linux VMs and their respective datadisks"
}