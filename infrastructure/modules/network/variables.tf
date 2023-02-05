
variable "location" {
  default     = "BrazilSouth"
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

variable "virtual_network" {
  default     = "10.1.0.0/16"
  description = "VNet address space"
}

variable "bastion_subnet" {
  default     = "10.1.10.0/26"
  description = "Jump Station address space"
}

variable "jump_station_subnet" {
  default     = "10.1.20.0/24"
  description = "Jump Station address space"
}