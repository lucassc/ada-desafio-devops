resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                = "${var.environment}-ada-database"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  version  = "5.7"
  sku_name = "B_Standard_B1s"

  backup_retention_days = 7
  zone                  = "2"

  administrator_login    = "user01"       // alterar para variavel segura
  administrator_password = "hDFS3.4242TT" // alterar para variavel segura

  delegated_subnet_id = azurerm_subnet.db_subnet.id
  private_dns_zone_id = azurerm_private_dns_zone.db_private_dns.id

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.vnet_dns_link
  ]
}

resource "azurerm_mysql_flexible_database" "mysql_database" {
  name                = "ada-database"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}