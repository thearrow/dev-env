#!/bin/bash

KUBERNETES_VERSION=1.6.2
KOPS_VERSION=1.5.3
HELM_VERSION=2.3.1
TERRAFORM_VERSION=0.9.4
PACKER_VERSION=1.0.0
DOCKER_VERSION=17.03.1
DOCKER_COMPOSE_VERSION=1.13.0-rc1
YARN_VERSION=0.23.2


sudo apt-get -q update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

# git, utils
sudo apt-get install -y -qq git unzip python-software-properties htop ncdu iotop nload

# python 3
sudo apt-get install -y -qq python3-pip

# ruby
sudo apt-get install -y -qq ruby-full

# kubectl
echo "downloading kubectl..."
wget --quiet https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
echo "source <(kubectl completion bash)" >> ~/.bashrc

# kops
echo "downloading kops..."
wget --quiet https://github.com/kubernetes/kops/releases/download/$KOPS_VERSION/kops-linux-amd64
chmod +x kops-linux-amd64
mv kops-linux-amd64 /usr/local/bin/kops

# helm
echo "downloading helm..."
wget --quiet https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz
tar -zxvf helm-v$HELM_VERSION-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
sudo rm -rf linux-amd64
sudo rm -f helm*.tar.gz

# terraform
echo "downloading terraform..."
wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
mv ./terraform /usr/local/bin/terraform
rm terraform*.zip

# packer
echo "downloading packer..."
wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip packer_${PACKER_VERSION}_linux_amd64.zip
mv ./packer /usr/local/bin/packer
rm packer*.zip

# awscli
sudo pip3 install --upgrade pip
sudo pip3 install --upgrade awscli 

# aws-mfa
gem install aws-mfa

# docker
echo "installing docker..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl --silent -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce=$DOCKER_VERSION~ce-0~ubuntu-xenial
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

# docker-compose
echo "installing docker-compose..."
curl --silent -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# nodejs
curl --silent -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y -q nodejs

# yarn
curl --silent -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install -y -qq yarn=${YARN_VERSION}-1


# print versions
git version
kubectl version
echo "kops: $(kops version)"
helm version
aws --version
terraform version
packer version
sudo docker version
docker-compose version
echo "NodeJS: $(node -v)"
echo "npm: $(npm -v)"
echo "Yarn: $(yarn --version)"
