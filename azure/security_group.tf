resource "azurerm_network_security_group" "dbright_chef" {
  name 			= "dbright-chef"
  location 		= "${var.location}"
  resource_group_name 	= "${azurerm_resource_group.dbright_rg.name}"

  security_rule {
	name 			= "AllowSSH"
	priority 		= 100
	direction 		= "Inbound"
	access 		        = "Allow"
	protocol 		= "Tcp"
	source_port_range       = "*"
    destination_port_range     	= "22"
    source_address_prefix      	= "*"
    destination_address_prefix 	= "*"
  }

  security_rule {
	name 			= "AllowHTTP"
	priority		= 200
	direction		= "Inbound"
	access 			= "Allow"
	protocol 		= "Tcp"
	source_port_range       = "*"
    destination_port_range     	= "80"
    source_address_prefix      	= "Internet"
    destination_address_prefix 	= "*"
  }

  tags = "${merge(var.default_tags, map(
    "Name", "dbright-sg",
  ))}"
}

