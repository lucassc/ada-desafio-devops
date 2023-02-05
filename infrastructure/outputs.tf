output "frontend_address" {
  description = "The Fqdn of frontend application"
  value       = "Access here the application: http://ada.${var.environment}.${module.aks.aks_agic_dns_zone}"
}