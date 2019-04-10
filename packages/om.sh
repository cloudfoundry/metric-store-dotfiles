#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "om" 0.55.0
FILE="om-linux"

if [[ `om --version` = "${VERSION}" ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://github.com/pivotal-cf/om/releases/download/${VERSION}/${FILE}
  chmod +x $FILE
  sudo mv $FILE /usr/local/bin/om
end_install
