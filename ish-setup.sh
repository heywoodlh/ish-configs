#!/usr/bin/env bash

# Install my dependencies
apk update
apk add vim git coreutils openssh-client mosh screen curl pass gnupg neofetch tmux file

# Setup pass
gpg --list-secret-keys | grep -q heywoodlh@ish || GPG_SETUP="false"

if [[ ${GPG_SETUP} == "false" ]]
then
   printf "Key-Type: RSA\nKey-Length: 3072\nName-Real: Spencer Heywood\nName-Email: heywoodlh@ish\nExpire-Date: 0\n" > /tmp/gpg.conf
   gpg --generate-key --batch /tmp/gpg.conf
   rm /tmp/gpg.conf
fi
pass ls > /dev/null || pass init heywoodlh@ish

# Setup a new SSH key stored in pass
pass ssh/id_rsa > /dev/null || PASS_SSH_SETUP="false"
if [[ ${PASS_SSH_SETUP} == "false" ]]
then
    ssh-keygen -f /tmp/id_rsa -N ""
    pass insert -m ssh/id_rsa < /tmp/id_rsa
    pass insert -m ssh/id_rsa.pub < /tmp/id_rsa.pub
    printf "ssh key info stored in password store\n"
    printf "private key: pass ssh/id_rsa\n"
    printf "public key: pass ssh/id_rsa.pub\n"
    rm /tmp/id_rsa
    rm /tmp/id_rsa.pub
fi

# Setup profile
cp profile ~/.profile

# Setup screen
cp screenrc ~/.screenrc

# Setup gitconfig
cp gitconfig ~/.gitconfig

# Setup vim
## Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp vimrc ~/.vimrc

# Create tmp dir
mkdir -p ~/tmp

# Setup tmux
cp tmux.conf ~/.tmux.conf
