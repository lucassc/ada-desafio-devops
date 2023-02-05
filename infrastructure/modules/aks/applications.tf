resource "helm_release" "ada-backend" {
  name  = "ada-backend"
  chart = "../backend/app/charts/api"

  set {
    name  = "image.version"
    value = var.backend_image_version
  }

  set {
    name  = "environment"
    value = var.environment
  }

  set {
    name  = "ingress.dnsZone"
    value = azurerm_kubernetes_cluster.k8s.http_application_routing_zone_name
  }

  set {
    name  = "envVariables.SPRING_DATASOURCE_URL"
    value = "jdbc:mysql://${var.database_server_fqdn}:3306/${var.database_name}"
  }

  set {
    name  = "envVariables.SPRING_DATASOURCE_USERNAME"
    value = var.database_username
  }

  set {
    name  = "envVariables.SPRING_DATASOURCE_PASSWORD"
    value = var.database_password
  }

  namespace        = "backend"
  create_namespace = true

  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

resource "helm_release" "ada-frontend" {
  name  = "ada-frontend"
  chart = "../frontend/app/charts/frontend"

  set {
    name  = "image.version"
    value = var.frontend_image_version
  }

  set {
    name  = "environment"
    value = var.environment
  }

  set {
    name  = "ingress.dnsZone"
    value = azurerm_kubernetes_cluster.k8s.http_application_routing_zone_name
  }

  set {
    name  = "envVariables.APP_API_BASE_URL"
    value = "http://api.ada.${var.environment}.${azurerm_kubernetes_cluster.k8s.http_application_routing_zone_name}"
  }


  namespace        = "frontend"
  create_namespace = true

  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

