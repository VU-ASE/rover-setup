# rover-setup

This repo contains configuration and setup files used on all debixes. It is a private repository and only to be used by maintainers.

## Usage

Simply run `make` at the root of the repo. If the custom Linux kernel is not yet built, it will prompt you to do so with the appropriate command (`sudo ./kernel/cross-compile-kernel.sh`).

**Note**: you might be asked to approve several file operations (rename) with an interactive prompt during kernel compilation.

## TODO

Install avahi into docker container for mDNS compatibility
