#!/bin/bash

. ~/workspace/metric-store-dotfiles/support/helpers.sh

# pull down plug.vim so we can manage all our other vim plugins
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install patched fonts for powerline
echo_header "Installing fonts"

# Refresh the font cache
sudo fc-cache -fv >/dev/null

echo_header "you may be prompted by a sudo password now"
git clone https://github.com/powerline/fonts.git --depth=1
pushd fonts
  ./install.sh
popd
rm -rf fonts
echo_footer "fonts installed"

echo_header "testing fly"
if [[ `fly -t cf-denver status` != "logged in successfully" ]]; then
    fly -t cf-denver login -c https://concourse.cf-denver.com
fi
echo_footer "fly tested"

SRC=$HOME/workspace/metric-store-dotfiles/config

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/alacritty

echo_header "link dotfiles"
ln -sf $SRC/init.vim $HOME/.config/nvim/init.vim
ln -sf $SRC/alacritty.yml $HOME/.config/alacritty/alacritty.yml
rcup -fv -x gitconfig -x zshrc -x bash_darwin -x init.vim -x alacritty.yml -d config
echo_footer "dotfiles linked"

echo_header "post install"

source $HOME/.profile
source $HOME/.bash_profile
source $HOME/.bashrc
source $HOME/.aliases

./post-install.sh

echo_header "Install NeoVim plugins"
nvim +PlugInstall +GoInstallBinaries +qall
echo_footer "NeoVim plugins installed"

# Install Oh My ZSH if we haven't already done so
echo_header "Install zsh"
if [ ! -f $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
ln -sf ~/workspace/metric-store-dotfiles/assets/agnoster-duet.zsh-theme $HOME/.oh-my-zsh/themes
rcup -fv -d config zshrc
echo_footer "zsh installed"

rm -f $HOME/.gitconfig
git config --global include.path "$SRC"/gitconfig
