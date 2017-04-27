#!/bin/bash

KUBERNETES_VERSION=1.6.2
KOPS_VERSION=1.5.3
HELM_VERSION=2.3.1
TERRAFORM_VERSION=0.9.4
PACKER_VERSION=1.0.0
DOCKER_VERSION=17.04.0
DOCKER_COMPOSE_VERSION=1.13.0-rc1


sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

# git
sudo apt-get install -y git

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
echo "source <(kubectl completion bash)" >> ~/.bashrc

# kops
wget https://github.com/kubernetes/kops/releases/download/$KOPS_VERSION/kops-linux-amd64
chmod +x kops-linux-amd64
mv kops-linux-amd64 /usr/local/bin/kops

# helm
wget https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz
tar -zxvf helm-v$HELM_VERSION-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

# python 3
sudo apt-get install -y python3-pip

# awscli
pip3 install awscli --upgrade --user
aws --version

# terraform
curl -O https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_$TERRAFORM_VERSION_linux_amd64.zip
unzip terraform_$TERRAFORM_VERSION_linux_amd64.zip
mv ./terraform /usr/local/bin/terraform

# packer
curl -O https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_$PACKER_VERSION_linux_amd64.zip
unzip packer_$PACKER_VERSION_linux_amd64.zip
mv ./packer /usr/local/bin/packer

# ruby
sudo apt-get install -y ruby-full

# aws-mfa
gem install aws-mfa

# docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce=$DOCKER_VERSION~ce-0~ubuntu-xenial

# docker-compose
curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# nodejs
sudo apt-get install -y python-software-properties
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
npm -v