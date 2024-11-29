#!/bin/bash

# Setup custom repository if provided
if [ ! -z "$2" ]; then
    /setup-repo.sh "$2"
fi

if [[ $1 == http* ]]; then
    # Handle Git URL
    git clone "$1" && cd "$(basename "$1" .git)"
else
    # Handle GitHub workspace files
    cd "$GITHUB_WORKSPACE/$1"
fi

makepkg -sf --noconfirm --skippgpcheck