
resource "azurerm_resource_group" "jumpstation_rg" {
  name     = "${var.environment}-jump-station"
  location = var.location
}


resource "azurerm_subnet" "jump-station" {
  name                 = "jump-station-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.jump_station_subnet]
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.environment}-jump-station-nic"
  location            = azurerm_resource_group.jumpstation_rg.location
  resource_group_name = azurerm_resource_group.jumpstation_rg.name

  ip_configuration {
    name                          = "configuration1"
    subnet_id                     = azurerm_subnet.jump-station.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "jump_station_01" {
  name                  = "${var.environment}-jump-station-vm"
  location              = azurerm_resource_group.jumpstation_rg.location
  resource_group_name   = azurerm_resource_group.jumpstation_rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"


  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-11"
    sku       = "win11-21h2-pro"
    version   = "latest"
  }

  os_profile_windows_config {

  }

  storage_os_disk {
    name              = "${var.environment}-jump-station-vm_OsDisk_1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "jump-station-vm"
    admin_username = "user01"          // alterar para variavel segura
    admin_password = "MjX3BCrn5YyeXhG" // alterar para variavel segura
  }


  tags = var.tags
}
