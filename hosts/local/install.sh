#!/bin/sh
brew install rg fd bat fzf pure zoxide

echo "Linking .zshrc"
ln -sf ${PWD}/zshrc ~/.zshrc

echo "Linking .config/*"
if [ -d "~/.config" ]; then
  mkdir ~/.config
fi
ln -sf ${PWD}/config/* ~/.config
