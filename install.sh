#!/usr/bin/env zsh

git pull origin master

rsync -avzh ./zshrc ~/.zshrc
rsync -avzh ./gitconfig ~/.gitconfig
rsync -avzh ./vimrc ~/.vimrc
rsync -avzh ./vim/* ~/.vim

source ~/.zshrc;

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  # vim-plug
  echo "Installing vim-plug.."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

