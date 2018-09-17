#!/bin/bash

set -ex

sudo apt update
sudo apt install -y automake build-essential pkg-config cmake net-tools
sudo apt install -y neovim tmux git curl htop tree silversearcher-ag openssh-server
sudo apt install -y python3 python3-pip jq zsh
sudo apt install -y libxml2 libxml2-dev libcurl4-gnutls-dev
sudo apt install -y fonts-inconsolata gnome-tweak-tool httpie

# these are required for lastpass-cli
sudo apt install -y libcurl4 libcurl4-openssl-dev libssl1.1 libssl-dev

sudo fc-cache -fv

packages/rust.sh
source $HOME/.cargo/env

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install patched fonts for powerline
git clone https://github.com/powerline/fonts.git --depth=1
pushd fonts
  ./install.sh
popd
rm -rf fonts

PACKAGES=`ls -d packages/*.sh`
for package in $PACKAGES
do
  echo "Running $package"
  $package
done;

fly -t log-cache login -c https://log-cache.ci.cf-app.com

SRC=$HOME/workspace/log-cache-dotfiles/config

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/alacritty

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
ln -sf $SRC/ruby-version $HOME/.ruby-version

source $HOME/.profile
source $HOME/.bash_profile
source $HOME/.bashrc
source $HOME/.aliases

./post-install.sh

nvim +PlugInstall +GoInstallBinaries +qall

# set caps lock to function as ctrl
setxkbmap -layout us -option ctrl:nocaps

# Install Oh My ZSH if we haven't already done so
if [ ! -f $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
