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
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "n01537188-rg"
}
