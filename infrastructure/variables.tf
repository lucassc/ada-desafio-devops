variable "environment" {
  default     = "development"
  description = "The environment"
}

variable "backend_image_version" {
  default     = "0.5.0"
  description = "The backend container image version"
}

variable "frontend_image_version" {
  default     = "0.4.0"
  description = "The frontend container image version"
}