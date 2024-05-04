#! /usr/bin/env bash
code --list-extensions |
xargs -L 1 echo code --install-extension |
sed "s/$/ --force/" |
sed "\$!s/$/ \&/" > $HOME/.dotfiles/scripts/vscode/install_vscode_exts.sh
chmod +x ./install_vscode_exts.sh
