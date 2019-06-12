resource "azurerm_storage_account" "db_storage" {
  name 			= "dbrightstorage"
  resource_group_name 	= "${azurerm_resource_group.dbright_rg.name}"
  location 		= "${var.location}"
  account_replication_type = "LRS"
  account_tier = "Standard"

  tags = "${merge(var.default_tags, map(
    "Name", "dbright-storage",
  ))}"
}

resource "azurerm_storage_container" "db_cont" {
  name 			= "vhds"
  resource_group_name 	= "${azurerm_resource_group.dbright_rg.name}"
  storage_account_name 	= "${azurerm_storage_account.db_storage.name}"
  container_access_type = "private"
}