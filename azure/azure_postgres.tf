resource "azurerm_postgresql_server" "dbpgchef" {
  name                = "dbpgchef"
  location            = "${azurerm_resource_group.dbright_rg.location}"
  resource_group_name = "${azurerm_resource_group.dbright_rg.name}"

  sku {
    name = "B_Gen5_2"
    capacity = 2
    tier = "Basic"
    family = "Gen5"
  }

  storage_profile {
    storage_mb = 10240
    backup_retention_days = 7
    geo_redundant_backup = "Disabled"
  }

  administrator_login = "chefadmin"
  administrator_login_password = "H@Sh1CoR3!"
  version = "9.6"
  ssl_enforcement = "Disabled"

  tags = "${merge(var.default_tags, map(
    "Name", "dbright-postgres",
  ))}"
}

resource "azurerm_postgresql_firewall_rule" "dbright" {
  name                = "office"
  resource_group_name = "${azurerm_resource_group.dbright_rg.name}"
  server_name         = "${azurerm_postgresql_server.dbpgchef.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

// ALTER ROLE opscode_chef WITH PASSWORD 'N9jpW}F%VZ';
// ALTER ROLE opscode_chef_ro WITH PASSWORD 'G5Utm2J#&n';
// ALTER ROLE bifrost WITH PASSWORD 'E@rC*^3$B=';
// ALTER ROLE bifrost_ro WITH PASSWORD 'R@m6K7qA#)';
// ALTER ROLE oc_id WITH PASSWORD 'nN4hP}J3UG';
// ALTER ROLE oc_id_ro WITH PASSWORD 'eVRjEhp9}r';