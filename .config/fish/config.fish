set fish_greeting

set -g -x EDITOR micro
set -g -x QT_QPA_PLATFORMTHEME qt6ct

if test -d /backup
    set -g -x UV_CACHE_DIR /backup/.uv
end

starship init fish | source

fish_add_path "/home/benjamin/.bun/bin"
fish_add_path "/home/benjamin/.local/bin"
fish_add_path "/home/benjamin/.venv/bin"

alias vv "source .venv/bin/activate.fish"
alias ls "eza"
alias nano "micro"

eval $(keychain --eval id_ed25519 -q --noask)
