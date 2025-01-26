# 3-Tier MERN Application on AWS EKS

This project demonstrates the deployment of a 3-tier MERN (MongoDB, Express, React, Node.js) application on AWS Elastic Kubernetes Service (EKS). The application consists of:

- **MongoDB** as the database layer
- **Node.js application** with the Express framework as the backend API
- **React** as the frontend

The entire infrastructure is created using Terraform, and AWS services like ALB (Application Load Balancer) and the AWS Controller are used to manage the ingress for routing traffic to the frontend and backend services.

Additionally, Prometheus and Grafana are deployed for monitoring the application, with custom Grafana dashboards to visualize metrics. ArgoCD is also used for GitOps-based deployment management.

## Architecture Overview

- **Frontend**: React application deployed in the EKS cluster.
- **Backend**: Node.js application using Express, deployed in the same cluster.
- **Database**: MongoDB, deployed as a stateful service in EKS.
- **Monitoring**: Prometheus and Grafana for system and application metrics.
- **Ingress**: AWS ALB routing frontend traffic to port 3000 and backend API traffic to port 5000.
- **Cluster Management**: Managed through EKS and ArgoCD.

## Deployment Steps

### 1. Infrastructure Setup

The infrastructure is provisioned using **Terraform**:

- **EKS Cluster**: The Kubernetes cluster is set up on AWS EKS.
- **MongoDB Deployment**: MongoDB is deployed as a stateful set in EKS for persistent storage.
- **Node.js Application**: Deployed as a Kubernetes deployment with Express as the backend.
- **React Frontend**: Deployed as a Kubernetes deployment serving the React application.
- **Ingress**: AWS Application Load Balancer (ALB) is used to route traffic to the appropriate services. The backend service is accessed on port 5000, and the frontend is on port 3000.

#### Terraform Configuration

All Terraform configurations for provisioning the AWS infrastructure, EKS cluster, and Kubernetes resources can be found in the `terraform/` directory.

### 2. Docker Image Creation & ECR Deployment

For the **frontend** and **backend** applications, Docker images are built using **multi-stage Docker builds** to optimize the images. These images are then pushed to **AWS Elastic Container Registry (ECR)** for deployment.

#### Docker Build Process

1. **Frontend (React)**:
   The frontend application is built using a multi-stage Dockerfile that first builds the React app in a Node.js environment, then copies the build artifacts to a minimal Nginx image for serving the static files.

2. **Backend (Node.js with Express)**:
   The backend application uses a multi-stage Dockerfile to build the application in a Node.js environment and then deploy it in a production-ready environment with all the necessary dependencies.

After building the Docker images locally, they are pushed to AWS ECR.

### 2. Monitoring Setup

**Prometheus and Grafana** are installed using **Helm charts** for monitoring:

- **Prometheus** collects metrics from various services within the cluster.
- **Grafana** is configured with a custom dashboard to display the collected metrics.

![frontend](/images/frontend.png)
![grafana](/images/prometheus.png)
![argocd](/images/argo.png)
