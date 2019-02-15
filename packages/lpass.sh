#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="LastPass CLI"
VERSION=1.3.1
FILE=lastpass-cli-$VERSION.tar.gz

echo_installing

if [[ `lpass --version` = "LastPass CLI v$VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
  mkdir -p $HOME/.local/share/lpass

  pushd $HOME/workspace
    mkdir lpass
    pushd lpass
      wget https://github.com/lastpass/lastpass-cli/releases/download/v$VERSION/$FILE
      tar -xzf $FILE
      cd lastpass-cli-$VERSION
      make
      sudo make install
    popd
    rm -rf lpass
  popd
end_install
