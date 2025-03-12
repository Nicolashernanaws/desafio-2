resource "kubernetes_namespace" "minio" {
  metadata {
    name = "minio-system"
  }
}

resource "kubernetes_deployment" "minio" {
  metadata {
    name      = "minio"
    namespace = kubernetes_namespace.minio.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "minio"
      }
    }

    template {
      metadata {
        labels = {
          app = "minio"
        }
      }

      spec {
        container {
          image = "minio/minio:latest"
          name  = "minio"
          
          args = ["server", "/data", "--console-address", ":9001"]
          
          env {
            name  = "MINIO_ROOT_USER"
            value = "minioadmin"
          }
          
          env {
            name  = "MINIO_ROOT_PASSWORD"
            value = "minioadmin"
          }
          
          port {
            container_port = 9000
            name = "api"
          }
          
          port {
            container_port = 9001
            name = "console"
          }
          
          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }
        
        volume {
          name = "data"
          
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.minio_data.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "minio_data" {
  metadata {
    name      = "minio-data"
    namespace = kubernetes_namespace.minio.metadata[0].name
  }
  
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}

resource "kubernetes_service" "minio_api" {
  metadata {
    name      = "minio"
    namespace = kubernetes_namespace.minio.metadata[0].name
  }
  
  spec {
    selector = {
      app = "minio"
    }
    
    port {
      port        = 9000
      target_port = 9000
      name        = "api"
    }
    
    type = "ClusterIP"
  }
}

resource "kubernetes_service" "minio_console" {
  metadata {
    name      = "minio-console"
    namespace = kubernetes_namespace.minio.metadata[0].name
  }
  
  spec {
    selector = {
      app = "minio"
    }
    
    port {
      port        = 9001
      target_port = 9001
      node_port   = 30900
      name        = "console"
    }
    
    type = "NodePort"
  }
}