#!/usr/bin/env zsh

git pull origin master

rsync -avzh ./zshrc ~/.zshrc
rsync -avzh ./gitconfig ~/.gitconfig
rsync -avzh ./vimrc ~/.vimrc
rsync -avzh ./vim/* ~/.vim

# host-dependent configs
HOSTNAME=$(hostname)
if [[ "$HOSTNAME" == "ywchoi.local" ]]; then
  rync -avzh ./zshrc.local ~/.zshrc.local
elif [[ "$HOSTNAME" == "palm.yonsei.ac.kr" ]]; then
  rync -avzh ./zshrc.palm ~/.zshrc.palm
elif [[ "$HOSTNAME" = "login"* ]]; then
  rync -avzh ./zshrc.nurion ~/.zshrc.nurion
fi

source ~/.zshrc;

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  # vim-plug
  echo "Installing vim-plug.."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

