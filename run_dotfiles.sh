#!/bin/bash

# Inspired from:
# https://github.com/kaicataldo/dotfiles/

# This will backup and symlink dot files below

# Reference files to symlink here
declare -a FILES_TO_SYMLINK=(
  'git/gitconfig'
  'git/gitignore'

  'shell/zshrc'
  'shell/inputrc'
  'shell/shell_config'
  'shell/shell_exports'

  'tmux/tmux.conf'

  'vim/vimrc'
)

# Warn user this script will overwrite current dotfiles
while true; do
  read -p "Warning: this will overwrite your current dotfiles. Continue? [y/n] " yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DIR_BACKUP="$HOME/dotfiles_old"

# Create dotfiles_old in homedir
echo -n "Creating $DIR_BACKUP for backup of any existing dotfiles..."
mkdir -p "$DIR_BACKUP"
echo "done"

# Move any existing dotfiles in homedir to dotfiles_old directory
for i in ${FILES_TO_SYMLINK[@]}; do
  targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
  if [ -e "$targetFile" ] && [ ! -L "$targetFile" ]; then
    echo "Backing up $targetFile to $DIR_BACKUP"
    mv -f "$targetFile" "$DIR_BACKUP/"
  fi
done

# Create symlinks (force overwrite so re-runs always update)
for i in ${FILES_TO_SYMLINK[@]}; do
  sourceFile="$DOTFILES_DIR/$i"
  targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
  echo "$targetFile → $sourceFile"
  ln -fs "$sourceFile" "$targetFile"
done

unset FILES_TO_SYMLINK

# Symlink bin scripts to ~/bin
echo "Symlinking bin scripts to ~/bin..."
mkdir -p "$HOME/bin"
for script in "$DOTFILES_DIR"/bin/*; do
  name="$(basename "$script")"
  ln -fs "$script" "$HOME/bin/$name"
  echo "$HOME/bin/$name → $script"
done

# Symlink vscode/settings.json to both VS Code and Cursor
echo "Symlinking vscode/settings.json..."

VSCODE_DIR="$HOME/Library/Application Support/Code/User"
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"

if [ -d "$VSCODE_DIR" ]; then
  ln -fs "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
  echo "$VSCODE_DIR/settings.json → $DOTFILES_DIR/vscode/settings.json"
fi

if [ -d "$CURSOR_DIR" ]; then
  ln -fs "$DOTFILES_DIR/vscode/settings.json" "$CURSOR_DIR/settings.json"
  echo "$CURSOR_DIR/settings.json → $DOTFILES_DIR/vscode/settings.json"
fi

echo "Done! You may need to restart your shell."
