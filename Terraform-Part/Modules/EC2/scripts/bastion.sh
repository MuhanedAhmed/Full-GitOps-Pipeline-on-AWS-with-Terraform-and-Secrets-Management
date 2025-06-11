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