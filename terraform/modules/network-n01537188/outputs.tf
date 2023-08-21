output "virtual_network_name" {
  value = azurerm_virtual_network.n01537188-vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.n01537188-subnet.name
}

output "n01537188-vnet" {
  value = azurerm_virtual_network.n01537188-vnet.name
}

output "n01537188-subnet" {
  value = {
    id   = azurerm_subnet.n01537188-subnet.id
    name = azurerm_subnet.n01537188-subnet.name
  }
}
