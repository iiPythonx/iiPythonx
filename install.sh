#!/usr/bin/bash
# Copyright (c) 2025 iiPython

# Handle linking
link() {
    if [ -L ~/$1 ] && [ -e ~/$1 ]; then
        echo "$1: already linked"
        return
    fi

    # Purge the old one
    rm -rfv ~/$1

    # Symlink the new one
    ln -s ~/.dotfiles/$1 ~/$1
    echo "$1: made link"
}

# Loop through config files
for item in .config/*; do
    link $item
done

# Symlink wallpapers
link .wallpapers

# Symlink theme
mkdir -p ~/.local/share/themes/GTK
link .local/share/themes/GTK/openbox-3
