#!/bin/bash

# Inspired from:
# https://github.com/kaicataldo/dotfiles/

# This will backup and symlink dot files below

# Reference files to symlink here
declare -a FILES_TO_SYMLINK=(
  'git/gitconfig'
  'git/gitignore'

  'shell/zshrc'
  'shell/gemrc'
  'shell/inputrc'
  'shell/shell_config'
  'shell/shell_exports'

  'tmux/tmux.conf'
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

# Get the dotfiles directory's absolute path
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
DIR="$(dirname "$SCRIPT_DIR")"

DIR_BACKUP=~/dotfiles_old   # old dotfiles backup directory

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create dotfiles_old in homedir
echo -n "Creating $DIR_BACKUP for backup of any existing dotfiles..."
mkdir -p $DIR_BACKUP
echo "done"

# Change to the dotfiles directory
echo -n "Changing to the $DIR directory..."
cd $DIR
echo "done"

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for i in ${FILES_TO_SYMLINK[@]}; do
  echo "Moving any existing dotfiles from ~ to $DIR_BACKUP"
  stat ~/.${i##*/} > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    mv -f ~/.${i##*/} ~/dotfiles_old/
  fi
done

# Do the actual symlinking
for i in ${FILES_TO_SYMLINK[@]}; do

  sourceFile="$DOTFILES_DIR/$i"
  targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

  if [ ! -e "$targetFile" ]; then
     echo "$targetFile → $sourceFile"
     CMD="ln -fs $sourceFile $targetFile"
     $CMD
  fi
done

unset FILES_TO_SYMLINK
