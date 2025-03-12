output "minikube_ip" {
  description = "Dirección IP de Minikube"
  value       = data.external.minikube_ip.result.ip
}