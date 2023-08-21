variable "location" {
  description = "Location for the resource group"
  type        = string
  default     = "canadacentral"
}

# All resources will have these tags
variable "personal" {
  type = map(string)
  default = {
    n_number = "n01537188",
    name     = "Suraj Mandal",
  }
}

variable "common_tags" {
  type = map(string)
  default = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Suraj.Mandal"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}


# Loadbalancer Independent Variables
variable "loadbalancer-rules" {
  type = map(string)
  default = {
    name          = "loadbalancer-rules"
    protocol      = "Tcp"
    frontend_port = "22"
    backend_port  = "22"
  }
}


variable "common_password" {
  default = "Password123!"
}