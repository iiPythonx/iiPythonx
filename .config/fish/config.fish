set fish_greeting
set -g -x EDITOR micro

starship init fish | source

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.rye/shims

alias v "source .venv/bin/activate.fish"
alias ls "eza"
alias nano "micro"

eval $(keychain --eval id_ed25519 -q --noask)
