#!/bin/bash

. ~/workspace/metric-store-dotfiles/support/helpers.sh

identify_package "git-duet" 0.7.0

if [[ `git-duet --version` == $VERSION* ]]; then
    echo_already_installed
    exit
fi

start_install
  mkdir -p ~/bin
  wget -O git-duet-$VERSION.tar.gz https://github.com/git-duet/git-duet/releases/download/$VERSION/linux_amd64.tar.gz
  tar xzvf git-duet-$VERSION.tar.gz -C ~/bin/
  rm git-duet-$VERSION.tar.gz
end_install
