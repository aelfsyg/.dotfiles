#!/usr/bin/env bash

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Exports

export LC_COLLATE="en_GB.utf8"
export TERMINAL="/usr/bin/alacritty"

export GOPATH=$HOME/src/go

# i3

HN=$(hostname)
DOT=$HOME/.dotfiles
CUSTOM=$DOT/i3/.i3/config.$HN
DEF=$DOT/i3/.i3/config.default
if [[ -f "$CUSTOM" ]]; then
	cat $CUSTOM > $DOT/i3/.i3/config
else
	cat $DEFAULT > $DOT/i3/.i3/config
fi

# Path

export PATH=$(zsh ~/.path.zsh)
