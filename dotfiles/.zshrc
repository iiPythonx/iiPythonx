#!/usr/bin/zsh
# iiPython .zshrc

# Exports
export PATH=$HOME/.bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export HIST_STAMPS="mm/dd/yyyy"
export LANG=en_US.UTF-8
export EDITOR="micro"

export ZSH_THEME="powerlevel10k/powerlevel10k"
export DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=7
export ENABLE_CORRECTION="false"  # zsh autocorrection sucks imo
export plugins=(git)

export SPICETIFY_INSTALL="$HOME/.spicetify"
export PATH="$SPICETIFY_INSTALL:$PATH"

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source $ZSH/oh-my-zsh.sh
source ~/.zsh/aliases

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Nice notice to myself
case $(tty) in
    (/dev/tty[1-9]) itty="tty";;
                (*) itty="nan";;
esac
if [ "$itty" = "tty" ]; then
    export EDITOR="nano"  # Micro will likely be broken in tty
    printf "Howdy, you appear to be using a tty;\nIf anything breaks, either use root or use full paths.\n"
fi
