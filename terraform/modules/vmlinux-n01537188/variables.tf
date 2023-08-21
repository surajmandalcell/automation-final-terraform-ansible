# Common
variable "common_tags" {
  type        = map(string)
  description = "This block is to define common tags"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

# This
variable "instance_count" {
  type        = number
  description = "Total number of Linux VMs"
}

variable "vmlinux-info" {
  type        = any
  description = "Contians information about the VM linux instances"
}

variable "vmlinux-avs-info" {
  type        = map(string)
  description = "Contains information about the availability set of linux VMs"
}

variable "vmlinux-nic" {
  type        = any
  description = "Contians information about the Network interface of linux VMs"
}

variable "vmlinux-pip" {
  type        = map(string)
  description = "Contians information about the public ip of linux VMs"
}

variable "vmlinux-network-watcher" {
  type        = any
  description = "Contains information about the Network watcher"
}

variable "vmlinux-network-monitor" {
  type        = any
  description = "Contains information about the Network monitor"
}
