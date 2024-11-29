#!/bin/bash

if [ ! -z "$1" ]; then
    echo "$1" >> /etc/pacman.conf
    pacman -Sy
fi