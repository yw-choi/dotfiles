#!/usr/bin/env zsh

git config --global user.email "ywchoi@berkeley.edu"
git config --global user.name  "Young Woo Choi"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/k

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install --all

BASEDIR=`realpath`
ln -sf ${BASEDIR}/z.sh ~/.z.sh
ln -sf ${BASEDIR}/p10k.zsh ~/.p10k.zsh
ln -sf ${BASEDIR}/zshrc ~/.zshrc.common

# neovim-related
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if [ ! -d ~/.config/nvim ] ; then
  mkdir -p ~/.config/nvim
fi
ln -sf ${BASEDIR}/init.vim ~/.config/nvim/init.vim
ln -sf ${BASEDIR}/init.vim ~/.vimrc

touch ~/.z

echo ">> Installing neovim plugins.."
nvim +PlugInstall +qall >/dev/null 2>&1
nvim +CocInstall coc-pyright coc-vimtex coc-json +qall >/dev/null 2>&1
