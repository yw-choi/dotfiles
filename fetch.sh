#!/usr/bin/env zsh

rsync -avzh ~/.zshrc ./zshrc

for host in local nurion palm;
do
  [[ -f ~/.zshrc.${host} ]] && rsync -avzh ~/.zshrc.${host} ./zshrc.${host}
done

rsync -avzh ~/.gitconfig ./gitconfig

rsync -avzh ~/.vimrc ./vimrc

for d in assets spell plugin ; do
  rsync -avzh ~/.vim/${d} ./vim
done

HOSTNAME=$(hostname)
if [[ "$HOSTNAME" = "login"* ]]; then
  rsync -avzh ~/.bash_profile ./bash_profile.nurion
  rsync -avzh ~/.tmux.conf ./tmux.conf.nurion
fi

