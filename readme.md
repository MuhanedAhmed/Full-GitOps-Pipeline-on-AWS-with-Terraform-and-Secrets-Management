# 🚀 GitOps-Based CI/CD Pipeline on AWS with EKS, Jenkins, ArgoCD, and Terraform

This project implements a fully automated, secure, and production-ready CI/CD pipeline using GitOps practices on AWS. It leverages Terraform for infrastructure provisioning, Jenkins for CI, ArgoCD for CD, and various open-source tools for observability, secrets management, and container lifecycle.

---

## 🧱 Architecture Overview

- **Infrastructure Provisioning**: Terraform
- **CI**: Jenkins on EKS using Kaniko
- **CD**: ArgoCD + Argo Image Updater
- **Secrets Management**: AWS Secrets Manager via External Secrets Operator
- **Ingress**: AWS ALB Ingress Controller
- **Cloud Provider**: AWS (EKS, VPC, ECR, IAM)

---

## 🔧 Infrastructure Components (Provisioned via Terraform)

- VPC with 3 Public and 3 Private Subnets across 3 AZs
- Internet Gateway, NAT Gateway, and Route Tables
- Amazon EKS Cluster:
  - Control Plane and Worker Nodes in Private Subnets
- Bastion Host in Public Subnet

---

## 🛡️ Bastion Host Configuration (via Ansible)

- Configured using Ansible Playbooks to:
  - Install system dependencies (`aws-cli`, `kubectl`, `helm`)
  - Configure access to EKS using `kubectl`

---

## 🤖 Jenkins CI Pipeline

- CI pipelines include:
  - Clone the project App from GitHub
  - Build Docker image using **Kaniko** inside Kubernetes
  - Push image to **Amazon ECR**

---
## 🚀 ArgoCD + Argo Image Updater for GitOps

  - ArgoCD installed via Helm in a dedicated namespace
  - GitOps model: ArgoCD watches Git repo and syncs Kubernetes manifests automatically
  - Auto-updates image tags in Git

---
## 🔐 Secrets Management with External Secrets Operator

  - Integrated with AWS Secrets Manager
  - Secrets are synced securely into Kubernetes as Secret objects

---
## 🌐 Secure App Exposure with Ingressr

  - AWS Load Balancer Controller handles Ingress resources
  - External ALB routes traffic to internal services
  - All nodes and control plane are private

## 💡 Key Highlights

  - Modular, production-ready infrastructure
  - Secure CI/CD workflows
  - GitOps-first design with ArgoCD
  - Private EKS cluster and nodes
