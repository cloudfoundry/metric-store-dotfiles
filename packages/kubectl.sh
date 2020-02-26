#!/bin/bash

. ~/workspace/metric-store-dotfiles/support/helpers.sh

identify_package "kubectl" 1.14.1

kubectlVersion=$(kubectl version 2>/dev/null | sed -r 's/.*GitVersion:"v([0-9\.]*)".*/\1/')
if [[ ${kubectlVersion} == "${VERSION}" ]]; then
    echo_already_installed
    exit
fi

start_install
  curl -LO https://storage.googleapis.com/kubernetes-release/release/v${VERSION}/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
end_install
