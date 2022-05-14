module "factory" {
  source         = "./modules/factory"
  google_project = var.google_project
  google_region  = var.google_region
}

module "network" {
  source         = "./modules/network"
  google_project = var.google_project
}