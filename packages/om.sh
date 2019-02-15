#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="om"
VERSION=0.47.0
FILE="om-linux"

echo_installing

if [[ `om --version` = "${VERSION}" ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://github.com/pivotal-cf/om/releases/download/${VERSION}/${FILE}
  chmod +x $FILE
  sudo mv $FILE /usr/local/bin/om
end_install
