#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "rcm" 1.3.3

if [[ `rcup -V | head -n1` == "rcup (rcm) $VERSION"* ]]; then
    echo_already_installed
    exit
fi

start_install
  pushd $HOME/workspace
    mkdir rcm
    pushd rcm
      wget https://thoughtbot.github.io/rcm/dist/rcm-$VERSION.tar.gz
      tar -xzf rcm-$VERSION.tar.gz
      cd rcm-$VERSION
      ./configure && make && sudo make install
    popd
    rm -rf rcm
  popd
end_install
