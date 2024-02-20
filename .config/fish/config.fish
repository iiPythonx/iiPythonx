set fish_greeting
starship init fish | source

fish_add_path ~/.local/bin

eval $(keychain --eval id_ed25519 -q --noask)
