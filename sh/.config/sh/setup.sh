#!/usr/bin/env bash

# echo "Running" $0

## SwayWM
isogeny \
    -t ~/.dotfiles/sway/.config/sway/config.template \
    -c ~/.dotfiles/sway/.config/sway/config.$(uname -n).edn \
    -d ~/.dotfiles/sway/.config/sway/config.default.edn \
    -o ~/.dotfiles/sway/.config/sway/config \
    --strict --verbose

## i3wm
isogeny \
    -t ~/.dotfiles/i3/.config/i3/config.template \
    -c ~/.dotfiles/i3/.config/i3/config.$(uname -n).edn \
    -d ~/.dotfiles/i3/.config/i3/config.default.edn \
    -o ~/.dotfiles/i3/.config/i3/config \
    --strict --verbose

## Alacritty
isogeny \
    -t ~/.dotfiles/alacritty/.config/alacritty/alacritty.yml.template \
    -c ~/.dotfiles/alacritty/.config/alacritty/alacritty.yml.$(uname -n).edn \
    -d ~/.dotfiles/alacritty/.config/alacritty/alacritty.yml.default.edn \
    -o ~/.dotfiles/alacritty/.config/alacritty/alacritty.yml \
    --strict --verbose

isogeny deploy --deploy-dir ~/.dotfiles \
    alacritty doom dunst fish fontconfig gammastep \
    git scripts sh sway vim wallpapers
