locals {
  instances = { for i in range(1, var.instance_count + 1) : i => "vmlinux-${i}" }
}

resource "azurerm_linux_virtual_machine" "n01537188-vmlinux" {
  resource_group_name = var.resource_group_name
  location            = var.location

  for_each = local.instances

  name = "${var.vmlinux-info.name}-${each.key}"

  computer_name  = each.value
  size           = var.vmlinux-info.size
  admin_username = var.vmlinux-info.admin_ssh_key.admin_username

  admin_ssh_key {
    username   = var.vmlinux-info.admin_ssh_key.admin_username
    public_key = file(var.vmlinux-info.admin_ssh_key.public_key)
  }

  availability_set_id = azurerm_availability_set.n01537188-vmlinux-avs.id

  network_interface_ids = [azurerm_network_interface.n01537188-vmlinux-nic[each.key].id]

  source_image_reference {
    publisher = var.vmlinux-info.source_image_reference.publisher
    offer     = var.vmlinux-info.source_image_reference.offer
    sku       = var.vmlinux-info.source_image_reference.sku
    version   = var.vmlinux-info.source_image_reference.version
  }

  os_disk {
    name                 = "${var.vmlinux-info.name}-osdisk-${each.key}"
    storage_account_type = var.vmlinux-info.os_disk.storage_account_type
    disk_size_gb         = var.vmlinux-info.os_disk.disk_size_gb
    caching              = var.vmlinux-info.os_disk.caching
  }

  boot_diagnostics {
    storage_account_uri = var.vmlinux-info.storage_account_uri
  }

  depends_on = [azurerm_availability_set.n01537188-vmlinux-avs]

  tags = var.common_tags
}

resource "azurerm_availability_set" "n01537188-vmlinux-avs" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = "${var.vmlinux-info.name}-avs"

  platform_fault_domain_count  = var.vmlinux-avs-info.platform_fault_domain_count
  platform_update_domain_count = var.vmlinux-avs-info.platform_update_domain_count

  tags = var.common_tags
}

resource "azurerm_public_ip" "n01537188-vmlinux-pip" {
  resource_group_name = var.resource_group_name
  location            = var.location

  for_each = local.instances

  name = "${var.vmlinux-info.name}-pip-${each.key}"

  allocation_method = var.vmlinux-pip.allocation_method

  domain_name_label = "${var.vmlinux-info.name}${each.key}"

  idle_timeout_in_minutes = var.vmlinux-pip.idle_timeout_in_minutes

  tags = var.common_tags
}

resource "azurerm_network_interface" "n01537188-vmlinux-nic" {
  resource_group_name = var.resource_group_name
  location            = var.location

  for_each = local.instances

  name = "${var.vmlinux-info.name}-nic-${each.key}"

  ip_configuration {
    name                          = "${var.vmlinux-info.name}-ipconfig-${each.key}"
    subnet_id                     = var.vmlinux-nic.ip-configuration.subnet_id
    private_ip_address_allocation = var.vmlinux-nic.ip-configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.n01537188-vmlinux-pip[each.key].id
  }

  tags = var.common_tags
}


resource "azurerm_virtual_machine_extension" "n01537188-vmlinux-network-watcher" {
  for_each = local.instances

  name               = "${var.vmlinux-info.name}-network-watcher-${each.key}"
  virtual_machine_id = azurerm_linux_virtual_machine.n01537188-vmlinux[each.key].id

  publisher                  = var.vmlinux-network-watcher.publisher
  type                       = var.vmlinux-network-watcher.type
  type_handler_version       = var.vmlinux-network-watcher.type_handler_version
  auto_upgrade_minor_version = var.vmlinux-network-watcher.auto_upgrade_minor_version

  settings = var.vmlinux-network-watcher.settings

  tags = var.common_tags
}

resource "azurerm_virtual_machine_extension" "n01537188-vmlinux-network-monitor" {
  for_each = local.instances

  name               = "${var.vmlinux-info.name}-azuremonitor-${each.key}"
  virtual_machine_id = azurerm_linux_virtual_machine.n01537188-vmlinux[each.key].id

  publisher                  = var.vmlinux-network-monitor.publisher
  type                       = var.vmlinux-network-monitor.type
  type_handler_version       = var.vmlinux-network-monitor.type_handler_version
  auto_upgrade_minor_version = var.vmlinux-network-monitor.auto_upgrade_minor_version

  settings = var.vmlinux-network-monitor.settings

  tags = var.common_tags
}
