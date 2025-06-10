#!/bin/bash

# Update package lists
sudo apt-get update

# Install Git
sudo apt-get install -y git

# Install Ansible
sudo apt-get install -y ansible

# Install Ansible community.kubernetes collection
ansible-galaxy collection install community.kubernetes

# Download and install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

git clone https://github.com/MuhanedAhmed/Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management.git
cd Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management

ansible-playbook ./Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management/Ansible-Part/eks-bastion-setup/playbook.yml \
-i ./Full-GitOps-Pipeline-on-AWS-with-Terraform-and-Secrets-Management/Ansible-Part/eks-bastion-setup/inventory.ini

# Verify installations
echo "Verifying installations..."

git --version
ansible --version
kubectl version --client

echo "Installation complete!"