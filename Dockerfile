FROM archlinux:latest

RUN pacman -Syu python base-devel base git pacman-contrib jemalloc mimalloc --noconfirm --overwrite '*' && \
    sed -i '/E_ROOT/d' /usr/bin/makepkg
COPY entrypoint.sh /entrypoint.sh
COPY setup-repo.sh /setup-repo.sh
RUN chmod +x /entrypoint.sh /setup-repo.sh
ENTRYPOINT ["/entrypoint.sh"]