resource "azurerm_subnet" "k8s_subnet" {
  name                 = "${var.environment}-k8s-ada-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg
  address_prefixes     = [var.k8s_subnet]

}

resource "azurerm_network_security_group" "network_security_group" {
  name                = "${azurerm_subnet.k8s_subnet.name}-nsg"
  location                = var.location
  resource_group_name     = var.vnet_rg

    security_rule {
    name                       = "HTTPS"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_network_security_group_association" {
  subnet_id                 = azurerm_subnet.k8s_subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}
