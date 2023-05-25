#!/usr/bin/env ash

## Enable location, allow iSH to run in background
grep -q '/dev/location' $HOME/.profile || echo 'cat /dev/location > /dev/null &' >> $HOME/.profile && source $HOME/.profile

# Install my dependencies
apk update
apk add vim git coreutils openssh-client mosh tmux curl

# Setup tmux
cp tmux.conf $HOME/.tmux.conf
grep TMUX $HOME/.tmux.conf || echo 'env | grep -q TMUX || tmux && exit' >> $HOME/.profile

# Install rbw
apk add cargo
cargo install rbw