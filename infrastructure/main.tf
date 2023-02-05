

module "network" {
  source = "./modules/network"

  environment = var.environment
}

module "database" {
  source = "./modules/database"

  vnet_name = module.network.vnet_name
  vnet_rg   = module.network.vnet_rg
  vnet_id   = module.network.vnet_id

  environment = var.environment

  depends_on = [
    module.network
  ]
}

module "aks" {
  source = "./modules/aks"

  vnet_name = module.network.vnet_name
  vnet_rg   = module.network.vnet_rg

  database_server_fqdn = module.database.database_server_fqdn
  database_name        = module.database.database_name
  database_username    = module.database.database_username
  database_password    = module.database.database_password

  backend_image_version  = var.backend_image_version
  frontend_image_version = var.frontend_image_version

  environment = var.environment
}

