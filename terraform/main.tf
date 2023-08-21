
module "rgroup-n01537188" {
  source              = "./modules/rgroup-n01537188"
  resource_group_name = "n01537188-rg"
  location            = var.location

  common_tags = var.common_tags
}

module "common-n01537188" {
  source               = "./modules/common-n01537188"
  storage_account_name = var.storage_account_name
  resource_group_name  = module.rgroup-n01537188.resource_group_name
  location             = var.location

  common_tags = var.common_tags
}

module "network-n01537188" {
  source               = "./modules/network-n01537188"
  virtual_network_name = "n01537188-vnet"
  subnet_name          = "n01537188-subnet"
  resource_group_name  = module.rgroup-n01537188.resource_group_name
  location             = var.location

  common_tags = var.common_tags
}

module "database-n01537188" {
  source                       = "./modules/database-n01537188"
  humber_id                    = var.personal.n_number
  location                     = var.location
  resource_group_name          = module.rgroup-n01537188.resource_group_name
  sku_name                     = "GP_Gen5_2"
  postgresql_version           = "10"
  administrator_login_password = var.common_password

  common_tags = var.common_tags
}

module "vmlinux-n01537188" {
  source = "./modules/vmlinux-n01537188"

  instance_count      = 3
  location            = var.location
  resource_group_name = module.rgroup-n01537188.resource_group_name

  vmlinux-info = {
    name          = "n01537188-linux"
    computer_name = "n01537188-computer_name"
    size          = "Standard_B1s"

    storage_account_uri = module.common-n01537188.storage_account-primary_blob_endpoint

    admin_ssh_key = {
      admin_username = "n01537188"
      public_key     = "~/.ssh/id_rsa.pub"
    }

    private_key = "~/.ssh/id_rsa"

    os_disk = {
      storage_account_type = "Standard_LRS"
      disk_size_gb         = "32"
      caching              = "ReadWrite"
    }

    source_image_reference = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_2"
      version   = "latest"
    }
  }

  vmlinux-avs-info = {
    name                         = "linux-avs"
    platform_update_domain_count = "3"
    platform_fault_domain_count  = "2"
  }

  vmlinux-nic = {
    ip-configuration = {
      subnet_id                     = module.network-n01537188.n01537188-subnet.id
      private_ip_address_allocation = "Dynamic"
    }
  }

  vmlinux-pip = {
    allocation_method       = "Dynamic"
    idle_timeout_in_minutes = "30"
  }

  vmlinux-network-watcher = {
    publisher                  = "Microsoft.Azure.NetworkWatcher"
    type                       = "NetworkWatcherAgentLinux"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
        {}
    SETTINGS
  }

  vmlinux-network-monitor = {
    publisher                  = "Microsoft.Azure.Monitor"
    type                       = "AzureMonitorLinuxAgent"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
      {}
  SETTINGS
  }

  common_tags = var.common_tags
}

module "datadisk-n01537188" {
  source = "./modules/datadisk-n01537188"

  location            = var.location
  resource_group_name = module.rgroup-n01537188.resource_group_name

  vmlinux-datadisk-info = {
    n01537188-vmlinux-names = module.vmlinux-n01537188.n01537188-vmlinux.hostnames
    total-vms               = 3
    storage_account_type    = "Standard_LRS"
    create_option           = "Empty"
    disk_size_gb            = 10
  }

  vmlinux-datadisk-attachment-info = {
    virtual_machine_ids = module.vmlinux-n01537188.n01537188-vmlinux.ids
    lun                 = "0"
    caching             = "ReadWrite"
  }

  common_tags = var.common_tags
}

module "loadbalancer-n01537188" {
  source = "./modules/loadbalancer-n01537188"

  location            = var.location
  resource_group_name = module.rgroup-n01537188.resource_group_name

  loadbalancer-name = "n01537188-loadbalancer"
  allocation_method = "Dynamic"

  loadbalancer-backend_pool_association = {
    count     = 3
    hostnames = module.vmlinux-n01537188.n01537188-vmlinux.hostnames
    nic-ids   = module.vmlinux-n01537188.n01537188-vmlinux.nic-ids
  }

  loadbalancer-rules = var.loadbalancer-rules

  common_tags = var.common_tags
}
