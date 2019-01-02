#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new Ubuntu machine
# 
# This should be idempotent so it can be run multiple times.
#
#
# Notes:
#
#
# Reading:
#
# 
# TO DO: 
# Find a way to install gnome extensions
# - Frippery Move Clock
# - Extensions
# - Hide Activities Button
# - Places Status Indicator
# - Remove Dropdown Arrows
# - Status Area Horizontal Spacing
# - NetSpeed
# - Dash to Dock
# - Workspaces to Dock
# - Pomodoro
# - Redshift
#

log_header() {
    echo ""
    echo "---  $1  ---"
    echo "---------------------------------------------"   
}

log_line() {
    echo "### $1 #"
}

log_line "Starting bootstrapping"

log_header "Add apt repositories"
sudo add-apt-repository ppa:vlijm/nonotifs

# zsh-completions
# z

log_header "Update apt"
sudo apt update

log_header "Installing apt packages..."
PACKAGES=(
    ack
    copyq
    copyq-plugins
    curl
    ffmpeg
    git
    gnome-calendar
    nonotifs
    openvpn
    terminator
    unity-tweak-tool
    vlc
    zsh
)

sudo apt install ${PACKAGES[@]}

log_header "Installing snap packages..."
PACKAGES=(
	brave
	chromium
	mailspring
	pats-boostnote
	postman
	spotify
	vscode
)

sudo snap install ${PACKAGES[@]}

log_header "Installing .deb with wget"
log_line "Franz"
wget -c https://github.com/meetfranz/franz/releases/download/v5.0.0-beta.18/franz_5.0.0-beta.18_amd64.deb -O franz.deb | sudo apt install ./franz.deb

log_line "NVM"
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

log_line "DropBox"
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - | ./.dropbox-dist/dropboxd

log_header "Configuring ubuntu..."

log_header "Creating folder structure..."
[[ ! -d ~/sites ]] && mkdir ~/sites

log_header "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

log_line "Bootstrapping complete"

