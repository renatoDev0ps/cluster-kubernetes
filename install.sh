#!/bin/bash

echo "+---------------------------+"
echo "| update and upgrade server |"
echo "+---------------------------+"
sudo apt update
sudo install -y gconf2-common gconf-service libgconf-2-4 cri-tools
sudo apt --fix-broken install
echo "+---------------------------------+"
echo "| install dependencies on server  |"
echo "+---------------------------------+"
sudo apt install -y vim \
  && curl \
  && wget \
  && unzip \
  && zip \
  && build-essential \
  && git \
  && net-tools \
  && nmap \
  && apt-transport-https \
  && ca-certificates \
  && software-properties-common \
  && rsync
echo "+---------------------------+"
echo "| install docker on server  |"
echo "+---------------------------+"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install -y docker-ce
sudo usermod -aG docker ${USER}
sudo chown ${USER}:docker /var/run/docker.sock
docker -v
sleep 2
echo "+--------------------------+"
echo "|  install docker compose  |"
echo "+--------------------------+"
sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v
sleep 2
echo "+--------------------------+"
echo "| install nodeJS on server |"
echo "+--------------------------+"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs
echo "node version"
node --version
sleep 2
echo "+-------------------------+"
echo "| install yarn on server  |"
echo "+-------------------------+"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y yarn
sudo apt install --no-install-recommends yarn
yarn -v
sleep 2
echo "+----------------------------------+"
echo "| install mongo compass on server  |"
echo "+----------------------------------+"
wget https://downloads.mongodb.com/compass/mongodb-compass_1.22.1_amd64.deb
sudo dpkg --install mongodb-compass_1.22.1_amd64.deb
sleep 2
echo "+--------------------------------------+"
echo "| Add Kubernetes repository on server  |"
echo "+--------------------------------------+"
sudo apt install apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt --fix-broken install
echo "+--------------------------------------------+"
echo "| install kubelet kubeadm kubectl on server  |"
echo "+--------------------------------------------+"
sudo apt install -y kubeadm kubelet kubectl kubernetes-cni
sudo apt-mark hold kubelet kubeadm kubectl
sudo apt --fix-broken install
echo "+-----------------------------+"
echo "| install minikube on server  |"
echo "+-----------------------------+"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sleep 2
echo "+--------------------------------+"
echo "| disable swap memory on server  |"
echo "+--------------------------------+"
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab && sudo swapoff -a && sudo rm -f -r /swapfile
sleep 2
echo "+--------------------------+"
echo "| install helm in kubectl  |"
echo "+--------------------------+"
curl -O https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
bash ./get-helm-3
helm version
helm repo add stable https://charts.helm.sh/stable
sleep 2
echo "+----------------------------------+"
echo "| finished installation on server  |"
echo "+----------------------------------+"
