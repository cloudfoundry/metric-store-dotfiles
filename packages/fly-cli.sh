#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "fly" 4.2.5

if [[ `fly --version` = "$VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://github.com/concourse/fly/releases/download/v$VERSION/fly_linux_amd64
  sudo mv fly_linux_amd64 /usr/local/bin/fly
  chmod +x /usr/local/bin/fly
end_install
