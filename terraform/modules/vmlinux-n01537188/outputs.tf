output "n01537188-vmlinux" {
  value = {
    ids       = values(azurerm_linux_virtual_machine.n01537188-vmlinux)[*].id
    hostnames = values(azurerm_linux_virtual_machine.n01537188-vmlinux)[*].name
    nic-ids   = values(azurerm_linux_virtual_machine.n01537188-vmlinux)[*].network_interface_ids[0]
  }
}

output "n01537188-vmlinux-fqdn" {
  value = values(azurerm_public_ip.n01537188-vmlinux-pip)[*].fqdn
}

output "n01537188-vmlinux-private-ip" {
  value = values(azurerm_linux_virtual_machine.n01537188-vmlinux)[*].private_ip_address
}

output "n01537188-vmlinux-public-ip" {
  value = values(azurerm_linux_virtual_machine.n01537188-vmlinux)[*].public_ip_address
}

output "n01537188-vmlinux-nic-ids" {
  value = [values(azurerm_network_interface.n01537188-vmlinux-nic)[*].id]
}
