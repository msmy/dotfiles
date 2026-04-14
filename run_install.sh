#!/bin/bash

echo "Installing scripts from install folder"

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# oh-my-zsh
"$DOTFILES_DIR/install/omz.sh"

# Package managers & packages
"$DOTFILES_DIR/install/brew.sh"

# vim-plug
"$DOTFILES_DIR/install/vim-plug.sh"

# Install a default Node version via fnm (needed before npm.sh)
if command -v fnm &> /dev/null; then
  eval "$(fnm env)"
  fnm install --lts
fi

# npm config & global packages
"$DOTFILES_DIR/install/npm.sh"

# Cask applications
"$DOTFILES_DIR/install/brew-cask.sh"
