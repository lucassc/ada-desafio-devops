
variable "location" {
  default     = "Brazil South"
  description = "Location of the resource group."
}

variable "environment" {
  default     = "development"
  description = "The environment"
}

variable "vnet_name" {
  description = "The Virtual Network name"
}

variable "vnet_rg" {
  description = "The Virtual Network Resoure Group name"
}

variable "vnet_id" {
  description = "The Virtual Network Id"
}

variable "database_subnet" {
  default     = "10.1.30.0/24"
  description = "Database subnet address prefix"
}

variable "tags" {
  type        = map(any)
  description = "Resource Tags"
  default = {
    "env"     = "development"
    "project" = "ada"
  }
}
