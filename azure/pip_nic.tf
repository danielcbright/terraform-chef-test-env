resource "azurerm_public_ip" "dbright_pip" {
  name 				= "dbright_chef_pip"
  location 			= "${var.location}"
  resource_group_name 		= "${azurerm_resource_group.dbright_rg.name}"
  public_ip_address_allocation 	= "static"

  tags = "${merge(var.default_tags, map(
    "Name", "dbright-chef-pip",
  ))}"
}

resource "azurerm_network_interface" "public_nic" {
  name 		      = "dbright-public-nic"
  location 	      = "${var.location}"
  resource_group_name = "${azurerm_resource_group.dbright_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.dbright_chef.id}"

  ip_configuration {
    name 			= "LA-Terraform-WebPrivate"
    subnet_id 			= "${azurerm_subnet.dbright_subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id	= "${azurerm_public_ip.dbright_pip.id}"
  }
  tags = "${merge(var.default_tags, map(
    "Name", "dbright-chef-pip",
  ))}"
}
