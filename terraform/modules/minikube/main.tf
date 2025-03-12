resource "null_resource" "minikube_cluster" {
  provisioner "local-exec" {
    command = <<-EOT
      if ! minikube status >/dev/null 2>&1; then
        echo "Creando cluster Minikube..."
        minikube start --cpus=${var.minikube_cpus} --memory=${var.minikube_memory}mb --disk-size=20g
        
        # Habilitar addons necesarios
        minikube addons enable ingress
        minikube addons enable storage-provisioner
        minikube addons enable metrics-server
      else
        echo "Cluster Minikube ya está en ejecución"
      fi
    EOT
  }

  # Destroy provisioner
  provisioner "local-exec" {
    when    = destroy
    command = "minikube stop && minikube delete"
    on_failure = continue
  }
}

# Obtener la IP de Minikube
data "external" "minikube_ip" {
  program = ["sh", "-c", "echo \"{\\\"ip\\\":\\\"$(minikube ip 2>/dev/null || echo 'pending')\\\"}\""]
  depends_on = [null_resource.minikube_cluster]
}