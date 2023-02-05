resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.environment}-database-ada-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg
  address_prefixes     = [var.database_subnet]

  delegation {
    name = "dlg-Microsoft.DBforMySQL-flexibleServers"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
      name = "Microsoft.DBforMySQL/flexibleServers"
    }
  }
}


resource "azurerm_subnet_network_security_group_association" "subnet_network_security_group_association" {
  subnet_id                 = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = "${azurerm_subnet.db_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

resource "azurerm_private_dns_zone" "db_private_dns" {
  name                = "${var.environment}-ada-database.private.mysql.database.azure.com"
  resource_group_name = var.vnet_rg

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_dns_link" {
  name                  = "${var.environment}-vnet-ada-db-private-dns-zone"
  resource_group_name   = var.vnet_rg
  private_dns_zone_name = azurerm_private_dns_zone.db_private_dns.name
  virtual_network_id    = var.vnet_id

  tags = var.tags
}
