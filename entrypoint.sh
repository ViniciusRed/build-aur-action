#!/bin/bash

# Setup custom repository if provided
if [ ! -z "$2" ]; then
    /setup-repo.sh "$2"
fi

# Enable multilib if requested
if [ "$3" == "true" ]; then
    echo "Enabling multilib repository..."
    # Uncomment multilib lines in pacman.conf
    echo "[multilib]" >> /etc/pacman.conf
    echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
    echo "Refreshing package databases..."
    pacman -Syy
    echo "Multilib repository enabled successfully"
fi

# Install additional packages if provided
if [ ! -z "$4" ]; then
    echo "Installing additional packages: $4"
    # Convert comma-separated packages to space-separated
    PACKAGES=$(echo "$4" | tr ',' ' ' | tr -s ' ')
    pacman -S --noconfirm $PACKAGES
fi

# Check if input is a URL (http/https/git)
if [[ $1 =~ ^https?:// ]] || [[ $1 =~ ^git:// ]] || [[ $1 =~ \.git$ ]]; then
    # Handle Git URL
    echo "Detected URL source: $1"
    echo "Cloning repository..."

    # Validate URL format
    if ! [[ $1 =~ ^(https?|git)://[a-zA-Z0-9.-]+/.*$ ]]; then
        echo "Error: Invalid URL format: $1"; exit 1;
    fi

    git clone "$1" || { echo "Error: Failed to clone repository $1"; exit 1; }
    REPO_DIR="$(basename "$1" .git)"

    if [ ! -d "$REPO_DIR" ]; then
        echo "Error: Cloned directory $REPO_DIR not found"; exit 1;
    fi

    echo "Successfully cloned to: $REPO_DIR"
    if [ "$(pwd)" != "$REPO_DIR" ]; then
        cd "$REPO_DIR"
    else
        echo "Already in target directory, skipping cd"
    fi
else
   # Handle GitHub workspace files
    echo "Detected local source: $1"
fi

makepkg -sf --noconfirm --skippgpcheck