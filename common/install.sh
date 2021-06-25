#!/usr/bin/env zsh

git config --global user.email "ywchoi@berkeley.edu"
git config --global user.name  "Young Woo Choi"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install --all

TOPDIR=$(git rev-parse --show-toplevel)
BASEDIR=${TOPDIR}/common

rsync -avzh ${BASEDIR}/z.sh ~/.z.sh
rsync -avzh ${BASEDIR}/p10k.zsh ~/.p10k.zsh
rsync -avzh ${BASEDIR}/vimrc ~/.vimrc
rsync -avzh ${BASEDIR}/vim ~/.vim
rsync -avzh ${BASEDIR}/zshrc ~/.zshrc.common

touch ~/.z

