#!/bin/bash

# Install cask applications

apps=(
    rectangle
    iterm2
    docker
    raycast
    suspicious-package
)

for app in "${apps[@]}"; do
  if brew list --cask "$app" &>/dev/null; then
    echo "$app already installed via brew, skipping."
  else
    brew install --cask "$app" || echo "Warning: $app failed to install, may already exist outside of brew."
  fi
done
