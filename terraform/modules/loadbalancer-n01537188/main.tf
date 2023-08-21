resource "azurerm_public_ip" "n01537188-loadbalancer-pip" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = "${var.loadbalancer-name}-pip"

  allocation_method = var.allocation_method
  idle_timeout_in_minutes = "30"

  tags              = var.common_tags
}

resource "azurerm_lb" "n01537188-loadbalancer" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = var.loadbalancer-name

  frontend_ip_configuration {
    name                 = "${var.loadbalancer-name}-ipconfig"
    public_ip_address_id = azurerm_public_ip.n01537188-loadbalancer-pip.id
  }

  tags = var.common_tags
}

resource "azurerm_lb_backend_address_pool" "n01537188-loadbalancer-address_pool" {
  name            = "${var.loadbalancer-name}-address_pool"
  loadbalancer_id = azurerm_lb.n01537188-loadbalancer.id
}

resource "azurerm_network_interface_backend_address_pool_association" "n01537188-loadbalancer-nic-backend_pool_association" {
  count                   = var.loadbalancer-backend_pool_association.count
  network_interface_id    = var.loadbalancer-backend_pool_association.nic-ids[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.n01537188-loadbalancer-address_pool.id
  ip_configuration_name   = "${substr(var.loadbalancer-backend_pool_association.hostnames[0], 0, length(var.loadbalancer-backend_pool_association.hostnames[0]) - 2)}-ipconfig-${format("%d", count.index + 1)}"
}


resource "azurerm_lb_rule" "n01537188-loadbalancer-rules" {
  loadbalancer_id                = azurerm_lb.n01537188-loadbalancer.id
  name                           = var.loadbalancer-rules.name
  protocol                       = var.loadbalancer-rules.protocol
  frontend_port                  = var.loadbalancer-rules.frontend_port
  backend_port                   = var.loadbalancer-rules.backend_port
  frontend_ip_configuration_name = "${var.loadbalancer-name}-ipconfig"
}
