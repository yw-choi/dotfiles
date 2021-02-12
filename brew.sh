#!/usr/bin/env zsh

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

brew install node
brew install git
brew install vim
brew install bat
brew install fd
brew install gh
