resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-ada-cluster-rg"
  location = var.location
}
