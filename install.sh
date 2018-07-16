#!/bin/bash

set -ex

sudo apt update
sudo apt install -y automake build-essential pkg-config cmake
sudo apt install -y neovim tmux git curl htop silversearcher-ag openssh-server
sudo apt install -y fonts-inconsolata

sudo fc-cache -fv

./clone-repos.sh

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
ln -sf $SRC/profile $HOME/.profile
ln -sf $SRC/gemrc $HOME/.gemrc
ln -sf $SRC/aliases $HOME/.aliases
ln -sf $SRC/init.vim $HOME/.config/nvim/init.vim
ln -sf $SRC/alacritty.yml $HOME/.config/alacritty/alacritty.yml
