output "n01537188-loadbalancer-name" {
  value = azurerm_lb.n01537188-loadbalancer.name
}

output "n01537188-loadbalancer-ip" {
  value = azurerm_public_ip.n01537188-loadbalancer-pip.ip_address
}

