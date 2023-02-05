resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.environment}-ada-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["${var.virtual_network}"]
}