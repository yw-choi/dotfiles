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


# p10k
echo "INSTALLING powerlevel10k..."
P10KPATH=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
if [ ! -d "${P10KPATH}" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
  git -C ${P10KPATH} pull
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
ln -sf ${BASEDIR}/p10k.zsh ~/.p10k.zsh
ln -sf ${BASEDIR}/zshrc ~/.zshrc.common

# neovim-related
if [ ! -d ~/.config/nvim ] ; then
  ln -sf ${BASEDIR}/nvim ~/.config
fi
# ln -sf ${BASEDIR}/init.vim ~/.config/nvim/init.vim
# ln -sf ${BASEDIR}/coc-settings.json ~/.config/nvim/coc-settings.json
# ln -sf ${BASEDIR}/init.vim ~/.vimrc

# touch ~/.z

# echo ">> Installing neovim plugins.."
# nvim +PlugInstall +qall >/dev/null 2>&1
# nvim +CocInstall coc-pyright +qall >/dev/null 2>&1
