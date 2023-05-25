#!/usr/bin/env ash

## Enable location, allow iSH to run in background
grep -q '/dev/location' $HOME/.profile || echo 'cat /dev/location > /dev/null &' >> $HOME/.profile && source $HOME/.profile

# Install my dependencies
apk update
apk add vim git coreutils openssh-client mosh tmux curl

# Setup tmux
curl -L 'https://raw.githubusercontent.com/heywoodlh/conf/dde8be87772faad8f90d2d2c5257018677795506/dotfiles/tmux.conf' -o $HOME/.tmux.conf

# Install rbw
apk add cargo
cargo install rbw