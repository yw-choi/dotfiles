#!/usr/bin/env zsh
TOPDIR=$(git rev-parse --show-toplevel)
BASEDIR=${TOPDIR}/hosts/cori

ln -sf ${BASEDIR}/zshrc ~/.zshrc
ln -sf ${BASEDIR}/karabiner ~/.config/karabiner

