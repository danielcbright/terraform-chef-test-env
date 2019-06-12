resource "azurerm_virtual_machine" "dbright_chef" {
  name                  = "dbright-chef"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.dbright_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.public_nic.id}"]
  vm_size               = "Standard_D2s_v3"

#This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.2"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-1"
    vhd_uri       = "${azurerm_storage_account.db_storage.primary_blob_endpoint}${azurerm_storage_container.db_cont.name}/osdisk-1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "centoschef"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = "${merge(var.default_tags, map(
    "Name", "dbright-chef",
  ))}"
}

// postgresql['username'] = 'chefadmin@dbrightpgchef'
// postgresql['db_superuser'] = 'chefadmin@dbrightpgchef' # Postgres user you created
// postgresql['db_superuser_password'] = 'H@Sh1CoR3!' # That user's password
// postgresql['external'] = true # Must be set to true
// postgresql['port'] = 5432 # Only required if you change the default port
// postgresql['vip'] = 'dbrightpgchef.postgres.database.azure.com' # DNS entry from RDS

// 7e698df8baeefe050d54fd3c682987e7  -