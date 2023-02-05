output "aks_agic_dns_zone" {
  description = "The Zone Name of the HTTP Application Routing"
  value       = azurerm_kubernetes_cluster.k8s.http_application_routing_zone_name
}