#!/bin/bash

echo "Installing scripts from install folder"

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Package managers & packages
"$DOTFILES_DIR/install/brew.sh"
"$DOTFILES_DIR/install/npm.sh"
"$DOTFILES_DIR/install/brew-cask.sh"