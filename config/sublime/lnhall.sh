#!/usr/bin/env zsh
set -o errexit

config_path="$HOME/.config/sublime-text-3/Packages/User"
pkgs="Anaconda;Package Control;Preferences;Side Bar;"
pkgsarr=("${(@s/;/)pkgs}")

for pkg in $pkgsarr; do
    ln "$config_path/$pkg.sublime-settings" "$pkg.sublime-settings"
done
