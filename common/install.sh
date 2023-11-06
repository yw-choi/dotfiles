#!/usr/bin/env zsh
TOPDIR=$(git rev-parse --show-toplevel)
BASEDIR=${TOPDIR}/common

echo "INSTALLING ohmyzsh..."
# install ohmyzsh
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # install omz plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  omz update >& /dev/null
fi


# fzf
echo "INSTALLING fzf..."
if [ ! -d ~/.fzf ]; then
  git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf
else
  cd ~/.fzf && git pull && cd ~
fi
~/.fzf/install

echo "LINKING pre-configured scripts..."
ln -sf ${BASEDIR}/z.sh ~/.z.sh
ln -sf ${BASEDIR}/zshrc ~/.zshrc.common

# neovim-related
if [ ! -d ~/.config/nvim ] ; then
  ln -sf ${BASEDIR}/nvim ~/.config
fi
