#!/bin/bash

# Pin npm install versions by default
npm config set save-exact true

# Globally install with npm
# To list globally installed npm packages and version: npm list -g --depth=0
packages=(
)

if [ ${#packages[@]} -gt 0 ]; then
  npm install -g "${packages[@]}"
fi
