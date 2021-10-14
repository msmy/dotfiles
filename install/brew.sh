#!/bin/bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

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

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

apps=(
    yarn
    npm
    nvm
    bash-completion2
    coreutils
    moreutils
    findutils
    gnu-sed
    source-highlight
    the_silver_searcher
    tree
    wget
    wifi-password
    tmux
    vim
    z
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup
