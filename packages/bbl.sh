#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "bbl" 7.6.0

if [[ `bbl version` = "bbl $VERSION "* ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://github.com/cloudfoundry/bosh-bootloader/releases/download/v$VERSION/bbl-v$VERSION\_linux_x86-64
  sudo mv bbl-v$VERSION\_linux_x86-64 /usr/local/bin/bbl
  sudo chmod +x /usr/local/bin/bbl
end_install
