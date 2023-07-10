#!/bin/bash

# export PACKAGER="AntMan666 <945360554@qq.com>"

git clone "$1" && cd "$(basename "$1" .git)"
echo 'PACKAGER="AntMan666 <antman666@qq.com>"' >> /etc/makepkg.conf
updpkgsums
makepkg -sf --noconfirm --skippgpcheck
