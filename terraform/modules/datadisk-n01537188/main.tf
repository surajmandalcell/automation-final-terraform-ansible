# Linux
resource "azurerm_managed_disk" "n01537188-vmlinux-datadisk" {
  resource_group_name = var.resource_group_name
  location            = var.location

  # count = var.vmlinux-datadisk-info.total-vms
  count                = length(var.vmlinux-datadisk-info.n01537188-vmlinux-names)
  name                 = "${var.vmlinux-datadisk-info.n01537188-vmlinux-names[count.index]}-datadisk-${format("%d", count.index + 1)}"
  storage_account_type = var.vmlinux-datadisk-info.storage_account_type
  create_option        = var.vmlinux-datadisk-info.create_option
  disk_size_gb         = var.vmlinux-datadisk-info.disk_size_gb

  tags = var.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "n01537188-vmlinux-datadisk-attachment" {
  count              = length(var.vmlinux-datadisk-info.n01537188-vmlinux-names)
  managed_disk_id    = azurerm_managed_disk.n01537188-vmlinux-datadisk[count.index].id
  virtual_machine_id = var.vmlinux-datadisk-attachment-info.virtual_machine_ids[count.index]
  lun                = var.vmlinux-datadisk-attachment-info.lun
  caching            = var.vmlinux-datadisk-attachment-info.caching

  depends_on = [azurerm_managed_disk.n01537188-vmlinux-datadisk]
}
