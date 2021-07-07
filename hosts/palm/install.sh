#!/usr/bin/env zsh
TOPDIR=$(git rev-parse --show-toplevel)
BASEDIR=${TOPDIR}/hosts/palm

ln -sf ${BASEDIR}/zshrc ~/.zshrc
