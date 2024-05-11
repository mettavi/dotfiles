#! /usr/bin/env bash

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
cd $scriptDir

# Download the git script for fzf
git clone git@github.com:junegunn/fzf-git.sh.git ~/

# This has to be applied after brew has installed cask logi-options-plus
patch /Library/Application\ Support/Logitech.localized/LogiOptionsPlus/app_permissions.json <./app_permissions.json.diff

# Download theme after brew has installed bat
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme --create-dirs --output $(bat --config-dir)/themes

# Set up symlink for vscode command line binary
ln -s "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" /usr/local/bin/code

# Copy after vscode is installed
./vscode/save_vscode_exts.sh
./vscode/install_vscode_exts.sh # must execute this before enabling git hooks in next command

# Point git to config file within repo
git config --local include.path ../.gitconfig
