resource "azurerm_resource_group" "dbright_rg" {
  name 		= "${var.resource_group_name}"
  location 	= "${var.location}"
}

resource "azurerm_virtual_network" "db_vnet" {
  name 			= "dbright-vnet"
  address_space 	= ["${var.vnet_cidr}"]
  location 		= "${var.location}"
  resource_group_name   = "${azurerm_resource_group.dbright_rg.name}"

  tags = "${merge(var.default_tags, map(
    "Name", "dbright-vnet",
  ))}"
}

resource "azurerm_subnet" "dbright_subnet_1" {
  name 			= "dbright-subnet-1"
  address_prefix 	= "${var.subnet1_cidr}"
  virtual_network_name 	= "${azurerm_virtual_network.db_vnet.name}"
  resource_group_name 	= "${azurerm_resource_group.dbright_rg.name}"
}

resource "azurerm_subnet" "dbright_subnet_2" {
  name 			= "dbright-subnet-2"
  address_prefix 	= "${var.subnet2_cidr}"
  virtual_network_name 	= "${azurerm_virtual_network.db_vnet.name}"
  resource_group_name 	= "${azurerm_resource_group.dbright_rg.name}"
}