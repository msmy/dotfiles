#!/bin/bash

# Install Caskroom
brew tap homebrew/cask
brew tap homebrew/cask-versions

# Install packages
apps=(
)

#brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzip qlimagesize webpquicklook suspicious-package
