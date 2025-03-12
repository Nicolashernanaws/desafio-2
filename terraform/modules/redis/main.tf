resource "kubernetes_namespace" "redis" {
  metadata {
    name = "redis-system"
  }
}

resource "kubernetes_deployment" "redis" {
  metadata {
    name      = var.redis_name
    namespace = kubernetes_namespace.redis.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis"
        }
      }

      spec {
        container {
          image = "redis:6.2-alpine"
          name  = "redis"
          
          port {
            container_port = 6379
          }
          
          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "redis" {
  metadata {
    name      = var.redis_name
    namespace = kubernetes_namespace.redis.metadata[0].name
  }
  
  spec {
    selector = {
      app = "redis"
    }
    
    port {
      port        = 6379
      target_port = 6379
    }
    
    type = "ClusterIP"
  }
}