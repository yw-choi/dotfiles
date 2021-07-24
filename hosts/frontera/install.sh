#!/usr/bin/env zsh
TOPDIR=$(git rev-parse --show-toplevel)
BASEDIR=${TOPDIR}/hosts/frontera

ln -sf ${BASEDIR}/zshrc ~/.zshrc
