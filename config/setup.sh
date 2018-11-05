#!/usr/bin/env zsh
set -o errexit

# setup
# 
# Set up custom configurations

cp zsh/.zshrc $HOME/.zshrc
ln -f $HOME/.zshrc zsh/.zshrc
cp zsh/bullet-train.zsh-theme $HOME/.oh-my-zsh/themes/bullet-train.zsh-theme

cp sublime/*.sublime-settings $HOME/.config/sublime*/Packages/User/
