#
# ~/.bash_profile
#

echo "Running ~/.bash_profile"

# export PATH=$PATH:/path/file
export PATH=$PATH:$HOME/.scripts
export PATH=$PATH:$HOME/.config/emacs/bin
export PATH=$PATH:$HOME/bin
export GOPATH=$HOME/src/go
export PATH=$PATH:$GOPATH/bin

# export a=$([ "$hostname" == "luna" ] && echo 2 || echo 1)
export GDK_SCALE=2 # must be an integer
export GDK_DPI_SCALE=1
export XCURSOR_SIZE=20
gsettings set org.gnome.desktop.interface cursor-size 20

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export ZDOTDIR=$HOME/.config/zsh

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/.npmrc
export GITLIBS=$XDG_CACHE_HOME/gitlibs

export MOZ_ENABLE_WAYLAND=1 firefox

[[ -f ~/.bashrc ]] && . ~/.bashrc

# HN=$(hostname)
# I3_CONFIG_DIR=$HOME/.config/i3
# CUSTOM=$I3_CONFIG_DIR/config.$HN
# DEFAULT=$I3_CONFIG_DIR/config.default
# if [[ -f "$CUSTOM" ]]; then
#     cat $CUSTOM > $I3_CONFIG_DIR/config
# else
#     cat $DEFAULT > $I3_CONFIG_DIR/config
# fi