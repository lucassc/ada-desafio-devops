

variable "location" {
  default     = "Brazil South"
  description = "Location of the resource group."
}

variable "environment" {
  default     = "development"
  description = "The environment"
}

variable "tags" {
  type        = map(any)
  description = "Resource Tags"
  default = {
    "env"     = "development"
    "project" = "ada"
  }
}


variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.24.9"
}

variable "agent_count" {
  description = "k8s workers"
  default     = 2
}

variable "vnet_name" {
  description = "The Virtual Network name"
}

variable "vnet_rg" {
  description = "The Virtual Network Resoure Group name"
}

variable "k8s_subnet" {
  default     = "10.1.40.0/24"
  description = "K8s subnet address prefix"
}

variable "ingress_app_gateway_subnet" {
  default     = "10.1.50.0/24"
  description = "Ingress App Gateway subnet address prefix"
}

variable "database_server_fqdn" {
  description = "The database server FQDN"
}

variable "database_name" {
  description = "The database name"
}

variable "database_username" {
  description = "The database username"
}

variable "database_password" {
  description = "The database username"
}

variable "backend_image_version" {
  description = "The backend container image version"
}

variable "frontend_image_version" {
  description = "The frontend container image version"
}
