#!/usr/bin/env zsh

git pull origin main;

rsync --exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude "install.sh" \
	--exclude "brew.sh" \
	--exclude "README.md" \
	-avh --no-perms . ~;

source ~/.zshrc;
