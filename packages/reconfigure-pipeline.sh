#!/usr/bin/env bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "reconfigure-pipeline" 0.23.0

if [ -f /usr/local/share/reconfigure-pipeline-$VERSION ]; then
    echo_already_installed
    exit
fi

start_install
  sudo rm /usr/local/share/reconfigure-pipeline-*
  wget -O reconfigure-pipeline-$VERSION.tar.gz https://github.com/pivotal-cf/reconfigure-pipeline/releases/download/v$VERSION/reconfigure-pipeline-linux.tar.gz
  tar -xzvf reconfigure-pipeline-$VERSION.tar.gz
  sudo mv reconfigure-pipeline /usr/local/share/reconfigure-pipeline-$VERSION
  sudo chmod +x /usr/local/share/reconfigure-pipeline-$VERSION
  ln -s /usr/local/share/reconfigure-pipeline-$VERSION /usr/local/bin/reconfigure-pipeline
  rm reconfigure-pipeline-$VERSION.tar.gz
end_install
