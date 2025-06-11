#!/bin/bash

# Update package lists
sudo apt-get update

# Install Git
sudo apt-get install -y git

# Install Ansible
sudo apt-get install -y ansible

# Install Ansible community.kubernetes collection
ansible-galaxy collection install community.kubernetes

git clone --branch mohaned https://github.com/MuhanedAhmed/Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management.git

cd Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management/Ansible-Part

until [ -s inventory.ini ]; do
  echo "Waiting for inventory.ini to become available..."
  sleep 2
done

ansible-playbook -i inventory.ini playbook.yaml

# Verify installations
echo "Verifying installations..."

git --version
ansible --version
kubectl version --client

# Creating ArgoCD Root App
echo "Creating ArgoCD Root App..."
cd ..
kubectl apply -f /Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management/ArgoCD-Part/root-app.yaml

# Wait until argocd-server service is available
until kubectl get svc argocd-server -n argocd; do
  echo "Waiting for ArgoCD server service..."
  sleep 5
done

# Start port forwarding for argocd
echo "Port Forwarding for Argo CD service..."
nohup kubectl port-forward service/argocd-server -n argocd 8090:443 > /var/log/port-forward.log 2>&1 &

# Wait until jenkins service is available
until kubectl get svc jenkins -n jenkins; do
  echo "Waiting for jenkins service..."
  sleep 5
done

# Start port forwarding for jenkins
echo "Port Forwarding for Argo CD service..."
nohup kubectl port-forward service/jenkins -n jenkins 8080:8080 > /var/log/jenkins-port-forward.log 2>&1 &