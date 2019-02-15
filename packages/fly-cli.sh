#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="fly"
VERSION=3.14.1

echo_installing

if [[ `fly --version` = "$VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://github.com/concourse/concourse/releases/download/v$VERSION/fly_linux_amd64
  sudo mv fly_linux_amd64 /usr/local/bin/fly
  chmod +x /usr/local/bin/fly
end_install
