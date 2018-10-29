#!/bin/bash

VERSION=0.2.1

if [[ `alacritty --version` = "alacritty $VERSION" ]]; then
    echo "Looks like alacritty $VERSION is already installed, skipping..."
    exit
fi

sudo apt-get update
sudo apt-get install -y cmake libfreetype6-dev libfontconfig1-dev xclip

pushd $HOME/workspace
  mkdir alacritty
  pushd alacritty
    wget https://github.com/jwilm/alacritty/archive/v$VERSION.zip
    unzip v$VERSION.zip
    cd alacritty-$VERSION
    cargo build --release
    sudo cp target/release/alacritty /usr/local/bin
    sudo desktop-file-install alacritty.desktop
    sudo update-desktop-database
  popd
  rm -rf alacritty
popd
