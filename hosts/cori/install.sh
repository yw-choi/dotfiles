#!/usr/bin/env zsh
TOPDIR=$(git rev-parse --show-toplevel)
BASEDIR=${TOPDIR}/hosts/cori
rsync -avzh ${BASEDIR}/zshrc ~/.zshrc
