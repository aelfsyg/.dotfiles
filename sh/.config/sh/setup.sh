#!/usr/bin/env bash

# echo "Running" $0

## SwayWM
SWAY=~/.dotfiles/sway/.config/sway
isogeny \
    -t $SWAY/config.template \
    -c $SWAY/config.$(uname -n).edn \
    -d $SWAY/config.default.edn \
    -o $SWAY/config \
    --strict --verbose

## i3wm
I3=~/.dotfiles/i3/.config/i3
isogeny \
    -t $I3/config.template \
    -c $I3/config.$(uname -n).edn \
    -d $I3/config.default.edn \
    -o $I3/config \
    --strict --verbose

## Alacritty
ALACRITTY=~/.dotfiles/alacritty/.config/alacritty
isogeny \
    -t $ALACRITTY/alacritty.yml.template \
    -c $ALACRITTY/alacritty.yml.$(uname -n).edn \
    -d $ALACRITTY/alacritty.yml.default.edn \
    -o $ALACRITTY/alacritty.yml \
    --strict --verbose

isogeny deploy --deploy-dir ~/.dotfiles \
    alacritty doom dunst fish fontconfig gammastep \
    git i3 picom scripts sh sway vim wallpapers
