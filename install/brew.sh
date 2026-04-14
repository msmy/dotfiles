#!/bin/bash

# Installs Homebrew and common dependencies for software development

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

apps=(
    coreutils
    moreutils
    findutils
    gnu-sed
    tree
    wget
    wifi-password
    tmux
    vim

    # Modern replacements
    fnm
    ripgrep
    bat
    zoxide
    gh
    fzf
    jq
    htop
    eza
    fd
    httpie
    tldr
    git-delta
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup
