terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2.0"
    }
  }
}


provider "kubernetes" {
  config_path    = var.kube_config_path
  config_context = "minikube"
}


module "minikube" {
  source          = "./modules/minikube"
  minikube_memory = var.minikube_memory
  minikube_cpus   = var.minikube_cpus
}


module "s3" {
  source      = "./modules/s3"
  bucket_name = "${var.project_name}-bucket"
  depends_on  = [module.minikube]
}


module "redis" {
  source     = "./modules/redis"
  redis_name = "${var.project_name}-redis"
  depends_on = [module.minikube]
}