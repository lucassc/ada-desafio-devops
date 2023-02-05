resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-database-rg"
  location = var.location
}