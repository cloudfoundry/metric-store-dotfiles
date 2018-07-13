#!/bin/bash

sudo apt-get update
sudo apt-get install -y cmake libfreetype6-dev libfontconfig1-dev xclip


git clone https://github.com/jwilm/alacritty.git
pushd alacritty
  cargo build --release
  sudo cp target/release/alacritty /usr/local/bin
  sudo desktop-file-install alacritty.desktop
  sudo update-desktop-database
popd
rm -rf alacritty

