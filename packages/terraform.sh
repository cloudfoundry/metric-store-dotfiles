#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "terraform" 0.11.11

if [[ `terraform version` = "Terraform v$VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip
  unzip terraform_${VERSION}_linux_amd64.zip
  rm  terraform_${VERSION}_linux_amd64.zip
  sudo mv terraform /usr/local/bin
  sudo chmod +x /usr/local/bin/terraform
end_install
