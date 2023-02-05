resource "azurerm_resource_group" "monitoring_rg" {
  name     = "${var.environment}-ada-monitoring-rg"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "k8s_law" {
  name                = "${var.environment}-ada-law"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  location            = azurerm_resource_group.monitoring_rg.location
  sku                 = "PerGB2018"

  tags = var.tags
}

resource "azurerm_log_analytics_solution" "containers_insights" {
  solution_name         = "ContainerInsights"
  workspace_resource_id = azurerm_log_analytics_workspace.k8s_law.id
  workspace_name        = azurerm_log_analytics_workspace.k8s_law.name
  location              = azurerm_resource_group.monitoring_rg.location
  resource_group_name   = azurerm_resource_group.monitoring_rg.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
