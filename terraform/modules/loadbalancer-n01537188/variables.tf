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
variable "loadbalancer-name" {
  type        = string
  description = "Name of the load balancer"
}

variable "allocation_method" {
  type        = string
  description = "Allocation method for the public IP address"
}

variable "loadbalancer-backend_pool_association" {
  type        = any
  description = "Contains information about the NIC and load balancer's backend_pool association"
}

variable "loadbalancer-rules" {
  type        = map(string)
  description = "Contains information about the firewall rules for load balancer"
}
