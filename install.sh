#!/bin/bash

set -ex

sudo apt update
sudo apt install -y automake build-essential pkg-config
sudo apt-get install neovim git curl htop silversearcher-ag openssh-server
sudo apt-get install fonts-inconsolata

sudo fc-cache -fv

PACKAGES=`ls -d packages/*.sh`
for package in $PACKAGES
do
  echo "Running $package"
  $package
done;

SRC=$HOME/workspace/log-cache-dotfiles/config

ln -sf $SRC/git-authors $HOME/.git-authors
ln -sf $SRC/gitconfig $HOME/.gitconfig
ln -sf $SRC/tmux.conf $HOME/.tmux.conf
ln -sf $SRC/bashrc $HOME/.bashrc
ln -sf $SRC/bash_profile $HOME/.bash_profile
ln -sf $SRC/gemrc $HOME/.gemrc
ln -sf $SRC/aliases $HOME/.aliases
ln -sf $SRC/vimrc $HOME/.config/nvim/init.vim
ln -sf $SRC/alacritty.yml $HOME/.config/alacritty/alacritty.yml
