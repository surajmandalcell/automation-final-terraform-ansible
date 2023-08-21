variable "storage_account_name" {
  default = "tfstaten01537188sa"
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "tfstaten01537188RG"
#     storage_account_name = var.storage_account_name
#     container_name       = "tfstaten01537188sac"
#     key                  = "terraform.tfstate"
#   }
# }
