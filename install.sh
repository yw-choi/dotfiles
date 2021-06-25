#!/usr/bin/env zsh

HOST=$1
HOSTLIST=("local" "cori")

main() {

  if [ -z "$HOST" ];
  then
    print_usage
    exit 1;
  fi

  if [[ ! "${HOSTLIST[@]}" =~ "${HOST}" ]]; then
    print_usage
    exit 2;
  fi

  echo "Start installing for host: $HOST"

  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --bin

  rsync -avzh ./common/z.sh ~/.z.sh
  rsync -avzh ./common/p10k.zsh ~/.p10k.zsh
  rsync -avzh ./common/vimrc ~/.vimrc
  rsync -avzh ./common/vim ~/vim
  rsync -avzh ./common/zshrc ~/.zshrc.common

  if [ -f ./hosts/${HOST}/install.sh ]; then
    ./hosts/${HOST}/install.sh
  fi

  # source ~/.zshrc;

  # if [ ! -f ~/.vim/autoload/plug.vim ]; then
  #   # vim-plug
  #   echo "Installing vim-plug.."
  #   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  #       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # fi
}

print_usage() {
  echo "[Usage] ./install.sh host"
  echo ""
  echo "host list"
  echo "- local"
  echo "- cori"
}

main
