#!/usr/bin/env zsh
TOPDIR=$(git rev-parse --show-toplevel)
BASEDIR=${TOPDIR}/hosts/local

ln -sf ${BASEDIR}/zshrc ~/.zshrc

