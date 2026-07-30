#!/usr/bin/bash
# Copyright (c) 2025-2026 iiPython

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

# Install font
if [ ! -d /usr/share/fonts/fira-code-nerd-font ]; then
    sudo cp -rv .fonts/fira-code-nerd-font /usr/share/fonts
    sudo fc-cache -f
fi
