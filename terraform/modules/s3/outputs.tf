output "minio_service" {
  description = "Nombre del servicio de MinIO"
  value       = "${kubernetes_service.minio_api.metadata[0].namespace}.${kubernetes_service.minio_api.metadata[0].name}"
}

output "minio_endpoint" {
  description = "Endpoint para acceder a MinIO"
  value       = "http://localhost:30900"
}