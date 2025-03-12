variable "minikube_cpus" {
  description = "Número de CPUs para Minikube"
  type        = number
  default     = 2
}

variable "minikube_memory" {
  description = "Memoria asignada a Minikube en MB"
  type        = number
  default     = 4096
}