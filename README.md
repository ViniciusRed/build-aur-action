# Build AUR Package GitHub Action

## Overview
This GitHub Action automates the process of building Arch User Repository (AUR) packages directly in your workflow. It supports building packages from Git URLs or local repository files, with additional features for multilib support and package installation.

## Features
- Build AUR packages from Git URLs
- Build packages from local GitHub workspace files
- Custom repository configuration
- Enable multilib repository
- Install additional packages before building

## Inputs

### `package-source` (Required)
The source of the package to build. Can be:
- A Git URL to an AUR package repository
- A local directory path within the GitHub workspace

### `custom-repo` (Optional)
Add a custom repository to `/etc/pacman.conf`. Useful for adding additional package sources.

### `enable-multilib` (Optional)
Enable the multilib repository in pacman.conf. Default: `false`.
Set to `true` to enable 32-bit library support.

### `install-packages` (Optional)
Additional packages to install before building (space-separated).
Useful for build dependencies not covered by the PKGBUILD.

## Usage Examples

### Basic Usage - Building from AUR Git URL
```yaml
- uses: viniciusred/build-aur-action@master
  with:
    package-source: 'https://aur.archlinux.org/yay.git'
```

### Building from Local Directory
```yaml
- uses: viniciusred/build-aur-action@master
  with:
    package-source: 'my-package-dir'
```

### With Custom Repository
```yaml
- uses: viniciusred/build-aur-action@master
  with:
    package-source: 'https://aur.archlinux.org/linux-ck-uksm.git'
    custom-repo: |
      [custom-repo]
      Server = http://your-custom-repo-url
      SigLevel = Optional TrustAll
```

### With Multilib Support
```yaml
- uses: viniciusred/build-aur-action@master
  with:
    package-source: 'https://aur.archlinux.org/wine.git'
    enable-multilib: 'true'
```

### With Additional Packages
```yaml
- uses: viniciusred/build-aur-action@master
  with:
    package-source: 'https://aur.archlinux.org/discord.git'
    install-packages: 'lib32-gcc-libs lib32-glibc'
```

### Complete Example with All Features
```yaml
- uses: viniciusred/build-aur-action@master
  with:
    package-source: 'https://aur.archlinux.org/wine-staging.git'
    enable-multilib: 'true'
    install-packages: 'lib32-gcc-libs lib32-glibc wine-gecko wine-mono'
    custom-repo: |
      [custom-wine-repo]
      Server = https://dl.winehq.org/wine-builds/arch/$arch
      SigLevel = Optional TrustAll
```