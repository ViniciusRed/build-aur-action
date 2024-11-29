# Build AUR Package GitHub Action

## Overview
This GitHub Action automates the process of building Arch User Repository (AUR) packages directly in your workflow. It supports building packages from Git URLs or local repository files.

## Features
- Build AUR packages from Git URLs
- Build packages from local GitHub workspace files
- custom repository configuration

## Inputs

### `package-source` (Optional)
**Required** The source of the package to build. Can be:
- A Git URL to an AUR package repository
- A local directory path within the GitHub workspace

### `custom-repo` 
Add a custom repository to `/etc/pacman.conf`. Useful for adding additional package sources.

## Usage Examples

### Building from AUR Git URL
```yaml
- uses: viniciusred/build-aur-action@master
  with:
    package-source: 'https://aur.archlinux.org/linux-ck-uksm.git'

  // Build from a local directory

  - uses: viniciusred/build-aur-action@master
  with:
    package-source: 'my-package-dir'

  // build from git url with custom repo

  - uses: viniciusred/build-aur-action@master
  with:
    package-source: 'https://aur.archlinux.org/linux-ck-uksm.git'
    custom-repo: |
      [custom-repo]
      Server = http://your-custom-repo-url
      SigLevel = Optional TrustAll
```