#!/bin/bash
# Script de instalação das ferramentas para ultilizar o easytrade no docker ou kubernetes
# ferramentas: -minikube, Docker, kubectl, curl

# Atualizar a lista de pacotes e instalar dependências
sudo apt update
sudo apt install -y curl vim nano apt-transport-https ca-certificates curl software-properties-common

# Adicionar a chave GPG do Docker
sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adicionar o repositório do Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizar a lista de pacotes e instalar o Docker
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adicionar o usuário atual ao grupo Docker
sudo usermod -aG docker $USER

# Baixar e instalar Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# Baixar e instalar kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# Verificar as instalações
echo "Docker version:"
docker --version

echo "Docker Compose version:"
docker-compose --version

echo "kind version:"
minikube --version

echo "kubectl version:"
kubectl version --client
