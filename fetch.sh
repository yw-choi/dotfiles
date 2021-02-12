#!/usr/bin/env zsh

rsync -avzh ~/.zshrc ./zshrc

for host in local nurion palm;
do
  [[ -f ~/.zshrc.${host} ]] && rsync -avzh ~/.zshrc.${host} ./zshrc.${host}
done

rsync -avzh ~/.gitconfig ./gitconfig
rsync -avzh ~/.vimrc ./vimrc
rsync -avzh ~/.vim/vimrcs ./vim
rsync -avzh ~/.vim/assets ./vim
rsync -avzh ~/.vim/spell  ./vim

