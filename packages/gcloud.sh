#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="Gcloud"
VERSION=234.0.0

echo_installing

if [[ `gcloud --version | head -1` = "Google Cloud SDK $VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION}-linux-x86_64.tar.gz -O google-cloud-sdk.tar.gz
  tar xzvf google-cloud-sdk.tar.gz -C /usr/local/share
  /usr/local/share/google-cloud-sdk/install.sh
  ln -s /usr/local/share/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
  ln -s /usr/local/share/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil
  rm google-cloud-sdk.tar.gz
  sudo chown pivotal: -R ~/.config/gcloud
end_install
