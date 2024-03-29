# Terraform - Infrastructure as Code Project

## Terraform Modules

This repository contains a set of Terraform child modules for provisioning various resources. The modules are designed to be used together in a root module to create a complete infrastructure deployment.

### Child Module: Resource Group

The `rgroup-RandomID` module provisions 1 resource group called RandomID-RG. The module returns the name of the resource group to the root module.

### Child Module: Networking

The `network-RandomID` module provisions 1 virtual network called RandomID-VNET and 1 subnet called RandomID-SUBNET in the RandomID-RG resource group. It also adds a network security group with 4 inbound access rules for ports 22, 3389, 5985, and 80. The network security group is associated with the subnet. This module returns the names of the virtual network and the subnet to the root module.

### Child Module: Common Services

The `common-RandomID` module provisions 1 log analytics workspace, 1 recovery services vault, and 1 standard storage account with LRS redundancy. The storage account created must be different from the one used as the Terraform backend. This module returns the names of the three resources to the root module.

### Child Module: Linux Virtual Machines

The `vmlinux-RandomID` module provisions 3 CentOS 8.2 Linux VMs with public IP addresses across 3 availability zones. Each VM uses the storage account blob container created above for VM boot diagnostics. The VMs have unique DNS labels assigned and have Network Watcher and Azure Monitor extensions installed. The hostnames, domain names, private IP addresses, and public IP addresses of the VMs are returned to the root module.

### Child Module: Data Disks

The `datadisk-RandomID` module provisions 4 x 10GB disks and attaches them to the 4 VMs.

### Child Module: Load Balancer

The `loadbalancer-RandomID` module provisions 1 public-facing basic load balancer with all 3 Linux VMs behind it. The name of the load balancer is returned to the root module.

### Child Module: Database

The `database-RandomID` module provisions 1 Azure DB for PostgreSQL Single Server instance. The name of the DB instance is returned to the root module.

### Root Module: Assignment1-RandomID

The `assignment1-RandomID` root module defines all child modules and prints the outputs received from child modules on a successful deployment.


TODO:
- [x] common-n01537188
- [x] database-n01537188
- [x] datadisk-n01537188
- [x] loadbalancer-n01537188
- [x] network-n01537188
- [x] rgroup-n01537188
- [x] vmlinux-n01537188
- [ ] ansible

# Common Commands

Get number of resources to be created
```
terraform plan -detailed-exitcode
```
