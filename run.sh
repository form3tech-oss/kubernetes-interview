#!/usr/bin/env bash

set -e

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
PRO=$(dpkg --print-architecture)

DOCKER_COMPOSE_VERSION=2.6.1
KIND_VERSION=0.17.0
GO_VERSION=1.19
KUBECTL_VERSION=1.25.3

echo "Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-$OS-$ARCH" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installing kind"
sudo curl -L "https://kind.sigs.k8s.io/dl/v$KIND_VERSION/kind-$OS-$PRO" -o /usr/local/bin/kind
sudo chmod +x /usr/local/bin/kind

echo "Installing kubectl"
sudo curl -L "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/$PRO/kubectl" -o /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl

echo "Installing go"
sudo curl -LO https://golang.org/dl/go$GO_VERSION.$OS-$PRO.tar.gz
sha256sum go$GO_VERSION.$OS-$PRO.tar.gz
sudo tar -C /usr/local -xvf go$GO_VERSION.$OS-$PRO.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> /home/vagrant/.profile