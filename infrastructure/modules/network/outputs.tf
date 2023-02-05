output "vnet_rg" {
  description = "The Virtual Network Resoure Group name"
  value       = azurerm_resource_group.rg.name
}

output "vnet_name" {
  description = "The Virtual Network name"
  value       = azurerm_virtual_network.virtual_network.name
}

output "vnet_id" {
  description = "The Virtual Network Id"
  value       = azurerm_virtual_network.virtual_network.id
}