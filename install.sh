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

  echo ">> Start installing for host: $HOST"

  echo ">> Installing common scripts"
  ./common/install.sh

  if [ -f ./hosts/${HOST}/install.sh ]; then
    echo ">> Installing host-specific scripts"
    ./hosts/${HOST}/install.sh
  else
    echo ">> Host-specific scripts not found. Skipping.."
  fi

  source ~/.zshrc;

  if [ ! -f ~/.vim/autoload/plug.vim ]; then
    # vim-plug
    echo "Installing vim-plug.."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  echo ">> Done!"
}

print_usage() {
  echo "[Usage] ./install.sh host"
  echo ""
  echo "host list"
  echo "- local"
  echo "- cori"
}

main
