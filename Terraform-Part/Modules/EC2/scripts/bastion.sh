#!/bin/bash

# Update package lists
sudo apt-get update

# Install Git
sudo apt-get install -y git

# Install Ansible
sudo apt-get install -y ansible

# Install Ansible community.kubernetes collection
ansible-galaxy collection install community.kubernetes

git clone --branch nayra https://github.com/MuhanedAhmed/Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management.git
cd Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management

ansible-playbook ./Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management/Ansible-Part/eks-bastion-setup/playbook.yml \
-i ./Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management/Ansible-Part/eks-bastion-setup/inventory.ini

# Verify installations
echo "Verifying installations..."

git --version
ansible --version
kubectl version --client

echo "Installing Argo Cd Image Updater..."

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml

echo "Port Forwarding for Argo CD service..."

kubectl port-forward service/argocd-server -n argocd 8090:443 