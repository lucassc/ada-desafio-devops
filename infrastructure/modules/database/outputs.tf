output "database_server_fqdn" {
  description = "The database server FQDN"
  value       = azurerm_mysql_flexible_server.mysql_server.fqdn
}

output "database_name" {
  description = "The database name"
  value       = azurerm_mysql_flexible_database.mysql_database.name
}


output "database_username" {
  description = "The database username"
  value       = azurerm_mysql_flexible_server.mysql_server.administrator_login
}

output "database_password" {
  description = "The database username"
  value       = azurerm_mysql_flexible_server.mysql_server.administrator_password
}
