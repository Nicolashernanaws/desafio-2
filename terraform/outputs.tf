output "minikube_ip" {
  description = "Dirección IP de Minikube"
  value       = module.minikube.minikube_ip
}

output "redis_service" {
  description = "Nombre del servicio de Redis"
  value       = module.redis.redis_service
}

output "minio_endpoint" {
  description = "URL de acceso a MinIO"
  value       = module.s3.minio_endpoint
}