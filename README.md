La arquitectura implementada consta de los siguientes componentes:

Minikube: Clúster Kubernetes local que simula un entorno de producción
Namespace nginx-system: Contiene la aplicación Nginx expuesta mediante NodePort
Namespace redis-system: Aloja la instancia de Redis utilizada por la aplicación
Namespace minio-system: Contiene el servidor MinIO para almacenamiento compatible con S3
Pipeline CI/CD: Integración continua mediante GitHub Actions

Componentes implementados
Infraestructura como Código (Terraform)

Módulo Minikube: Gestiona el ciclo de vida del clúster local
Módulo Redis: Despliega una instancia de Redis en el clúster
Módulo S3/MinIO: Implementa almacenamiento compatible con S3 mediante MinIO
Módulo Networking: Documentación de cómo sería en AWS (no utilizado en local)

Kubernetes y Helm

Chart Nginx: Implementa la aplicación Nginx con capacidad de comunicarse con Redis
ConfigMaps: Para contenido HTML y configuración de Nginx
Services: Tipo NodePort para exponer la aplicación en el puerto 30080

Automatización

Pipeline CI/CD: Workflow de GitHub Actions para validación y despliegue
Helm: Para gestionar el despliegue de manera declarativa

Requisitos previos

Terraform >= 1.0.0
Minikube >= 1.25.0
kubectl >= 1.21.0
Helm >= 3.8.0
Docker

Guía de implementación

Clonar el repositorio
bashCopygit clone https://github.com/Nicolashernanaws/desafio-2.git
cd desafio-2

Provisionar la infraestructura
bashCopycd terraform
terraform init
terraform apply

Desplegar la aplicación
bashCopykubectl create namespace nginx-system
helm install nginx-app ./helm/nginx-app -n nginx-system

Configurar acceso local
bashCopyecho "$(minikube ip) nginx.local" | sudo tee -a /etc/hosts

Acceder a la aplicación

Web: http://nginx.local:30080
MinIO: http://$(minikube ip):30900



Estructura del proyecto
Copydesafio-2/
├── .github/workflows/    # Configuración CI/CD
├── docs/                 # Documentación
│   └── architecture-diagram.png
├── helm/nginx-app/       # Chart de Helm para Nginx
│   ├── templates/        # Plantillas de recursos
│   ├── Chart.yaml        # Metadatos del chart
│   └── values.yaml       # Valores configurables
├── kubernetes/           # Manifiestos de Kubernetes
│   └── nginx-deployment.yaml
├── terraform/            # Código de infraestructura
│   ├── modules/          # Módulos reutilizables
│   │   ├── minikube/     # Gestión de Minikube
│   │   ├── networking/   # Configuración de red (documentación)
│   │   ├── redis/        # Implementación de Redis
│   │   └── s3/           # Implementación de MinIO
│   ├── main.tf           # Configuración principal
│   ├── outputs.tf        # Salidas
│   ├── variables.tf      # Variables
│   └── terraform.tfvars  # Valores de variables
└── README.md             # Este archivo
Estimación de costos (AWS)
Si esta infraestructura se implementara en AWS, los costos mensuales aproximados serían:
RecursoEspecificaciónCosto Mensual (USD)EKS Cluster1 cluster$73.00EC2 (Nodos)2 x t3.medium$60.00ElastiCache (Redis)cache.t3.micro$13.00S3 BucketAlmacenamiento básico$0.50Total$146.50
Nota: Esta implementación es local y no genera costos en la nube.
CI/CD Pipeline
La solución implementa un pipeline de CI/CD mediante GitHub Actions que:

Valida el código: Verifica la sintaxis y formato de Terraform y Helm
Inicializa Terraform: Prepara el entorno para la infraestructura
Planifica cambios: Muestra los recursos que se crearían/modificarían

ARQUITECTURA 
![image](https://github.com/user-attachments/assets/3550618b-373f-4804-9abe-e62d17547e5e)

            
