resource "azurerm_kubernetes_cluster" "k8s" {
  name                    = "${var.environment}-aks"
  location                = var.location
  resource_group_name     = var.vnet_rg
  dns_prefix              = "${var.environment}-ada-kubernetes"
  node_resource_group     = "${var.environment}-aks-node-pool-rg"
  kubernetes_version      = var.k8s_version
  private_cluster_enabled = false

  role_based_access_control_enabled = true

  api_server_access_profile {
    authorized_ip_ranges = ["0.0.0.0/0"]

  }


  default_node_pool {
    name            = "default"
    type            = "VirtualMachineScaleSets"
    node_count      = var.agent_count
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 40
    vnet_subnet_id  = azurerm_subnet.k8s_subnet.id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.k8s_law.id
  }


  http_application_routing_enabled = true

  tags = var.tags
}
