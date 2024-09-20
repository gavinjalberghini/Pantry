#!/usr/bin/env bash

## Echo text messaged in green to notify.
##
## e.g., `notify "This is a notice."`
##
function notify() {

  local green='\033[0;32m'
  local no_color='\033[0m'

  echo -e "${green}$1${no_color}"
}

## Echo text messaged in red to indicate an error.
##
## e.g., `error "This is an error."`
##
function error() {

  local red='\033[0;31m'
  local no_color='\033[0m'

  1>&2 echo -e "${red}$1${no_color}"
}

notify "Installing latest git..."
sudo add-apt-repository ppa:git-core/ppa -y > /dev/null 2>&1
sudo apt -qq update
sudo apt -qq install git -y

if ! command -v docker &> /dev/null; then 
  notify "Installing docker..."
  sudo apt install --yes apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository -y "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  apt-cache policy docker-ce
  sudo apt install --yes docker-ce
  sudo systemctl status docker --no-page
  notify "You will need to restart your instance for docker to work for you..."
  sudo usermod -aG docker $USER
  sudo newgrp docker
else
  notify "Docker already installed."
fi

notify "Installing kubectl..."
curl -SsL https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/$(uname |  tr '[:upper:]' '[:lower:]')/$(dpkg --print-architecture)/kubectl -o kubectl
sudo mv -f kubectl /usr/local/bin
sudo chmod +x /usr/local/bin/kubectl

notify "Installing helm..."
curl -SsLO https://get.helm.sh/helm-v3.8.2-$(uname |  tr '[:upper:]' '[:lower:]')-$(dpkg --print-architecture).tar.gz
tar -zxf helm-v3.8.2-$(uname |  tr '[:upper:]' '[:lower:]')-$(dpkg --print-architecture).tar.gz
sudo mv -f linux-$(dpkg --print-architecture)/helm /usr/local/bin
sudo chmod +x /usr/local/bin/helm
rm -Rf linux-$(dpkg --print-architecture)
rm helm-v3.8.2-$(uname |  tr '[:upper:]' '[:lower:]')-$(dpkg --print-architecture).tar.gz

notify "Installing kustomize..."
curl -SsL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.7/kustomize_v4.5.7_linux_$(dpkg --print-architecture).tar.gz | tar xz -C /tmp
sudo mv -f /tmp/kustomize /usr/local/bin

notify "Installing chef-inspec..."
sudo curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec > /dev/null 2>&1

notify "Installing terraform..."
sudo apt-get -qq update && sudo apt-get -qq install -y gnupg software-properties-common
sudo apt -qq install -y unzip
curl -SsLO https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_$(uname | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip
unzip -qq terraform_1.3.6_$(uname | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip
sudo mv -f terraform /usr/local/bin/terraform
sudo chmod +x /usr/local/bin/terraform
rm terraform_1.3.6_$(uname | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip

notify "Installing packer..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository -y "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /dev/null 2>&1
sudo apt-get -qq update
sudo apt-get -qq install packer

notify "Installing terraform docs..."
curl -sSLo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.17.0/terraform-docs-v0.17.0-$(uname)-$(dpkg --print-architecture).tar.gz
tar -xzf terraform-docs.tar.gz
chmod +x terraform-docs
sudo mv -f terraform-docs /usr/local/bin/terraform-docs
rm terraform-docs.tar.gz

notify "Installing sops..."
curl -SsLO https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.$(uname | tr '[:upper:]' '[:lower:]').$(dpkg --print-architecture)
sudo mv -f sops-v3.7.3.$(uname |  tr '[:upper:]' '[:lower:]').$(dpkg --print-architecture) /usr/local/bin/sops
sudo chmod +x /usr/local/bin/sops
