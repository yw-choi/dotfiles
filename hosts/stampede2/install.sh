#!/usr/bin/env zsh
TOPDIR=$(git rev-parse --show-toplevel)
BASEDIR=${TOPDIR}/hosts/stampede2

ln -sf ${BASEDIR}/zshrc ~/.zshrc
