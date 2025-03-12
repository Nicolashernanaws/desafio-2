variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "desafio-devops"
}

variable "kube_config_path" {
  description = "Ruta al archivo kubeconfig"
  type        = string
  default     = "~/.kube/config"
}

variable "minikube_memory" {
  description = "Memoria asignada a Minikube en MB"
  type        = number
  default     = 4096
}

variable "minikube_cpus" {
  description = "Número de CPUs para Minikube"
  type        = number
  default     = 2
}