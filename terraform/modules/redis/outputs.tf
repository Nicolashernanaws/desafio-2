output "redis_service" {
  description = "Nombre del servicio de Redis"
  value       = "${kubernetes_service.redis.metadata[0].namespace}.${kubernetes_service.redis.metadata[0].name}"
}