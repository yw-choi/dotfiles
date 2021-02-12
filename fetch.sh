#!/usr/bin/env zsh

rsync -avzh ~/.zshrc ./zshrc
rsync -avzh ~/.gitconfig ./gitconfig
rsync -avzh ~/.vimrc ./vimrc
rsync -avzh ~/.vim/vimrcs ./vim/vimrcs

