#!/bin/sh

echo "Linking .bashrc"
ln -sf ${PWD}/bashrc ~/.bashrc

echo "Linking .config/*"
if [ -d "~/.config" ]; then
  mkdir ~/.config
fi
ln -sf ${PWD}/config/* ~/.config
