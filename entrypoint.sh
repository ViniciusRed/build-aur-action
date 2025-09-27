#!/bin/bash

# Setup custom repository if provided
if [ ! -z "$2" ]; then
    /setup-repo.sh "$2"
fi

# Enable multilib if requested
if [ "$3" == "true" ]; then
    echo "Enabling multilib repository..."
    # Uncomment multilib lines in pacman.conf
    sed -i '/^#\[multilib\]/,/^#Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf
    pacman -Sy
fi

# Install additional packages if provided
if [ ! -z "$4" ]; then
    echo "Installing additional packages: $4"
    pacman -S --noconfirm $4
fi

if [[ $1 == http* ]]; then
    # Handle Git URL
    git clone "$1" && cd "$(basename "$1" .git)"
else
    # Handle GitHub workspace files
    cd "$GITHUB_WORKSPACE/$1"
fi

makepkg -sf --noconfirm --skippgpcheck