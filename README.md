# Desafío Técnico DevOps

Este repositorio contiene la solución al desafío técnico DevOps, implementando una infraestructura local con Minikube y desplegando una aplicación Nginx que puede interactuar con Redis y MinIO (equivalente a S3).

## Descripción del Proyecto

La solución implementa los siguientes componentes:

- **Infraestructura como Código (IaC)** utilizando Terraform
- **Clúster de Kubernetes** local con Minikube
- **Almacenamiento** equivalente a S3 utilizando MinIO
- **Redis** como base de datos en memoria
- **Automatización** del despliegue con Helm y CI/CD

## Estructura del Proyecto

desafio-2/
├── terraform/                 
│   ├── modules/
│   │   ├── minikube/         
│   │   ├── redis/            
│   │   ├── s3/               MinIO 
│   │   └── networking/       
│   ├── main.tf               
│   ├── variables.tf          
│   └── outputs.tf            
├── helm/                      
│   └── nginx-app/
│       ├── templates/        
│       ├── Chart.yaml        
│       └── values.yaml       
├── kubernetes/                
├── .github/                   
│   └── workflows/
│       └── ci-cd.yaml        
├── docs/                      
│   └── architecture-diagram.png 
└── README.md

echo "" >> README.md
echo "## CI/CD Status" >> README.md
echo "Este proyecto utiliza GitHub Actions para CI/CD." >> README.md                  
