# Overview
This repo will install all necessary dependencies and configurations using Ansible and some bash scripts. The flexibility of scripting allows the project to stay consistent with the original [Debix base image](https://debix.io/Software/download.html). For a full tutorial on how to get started with the Debix visit todo-docs-page.


# Zero to Hero
After booting a new Debix, make sure you are logged in as the default "debix" user, the **installation might not work otherwise**. Simply clone the repository inside the home directory (/home/debix) and run the idempotent the init script.
``` bash
# todo change this to main branch!
curl -fsSL https://raw.githubusercontent.com/VU-ASE/rover-setup/testing/install.sh | sh
```

# Overview

### Software Dependencies
* python3
* python3-pip
* Ansible
* Go version 1.22.0
* libzmp3-dev
* vim
* cmake
* curl

### Manual Builds
* GOCV has been prebuilt and only needs to be make-installed.

## todo:
- Connect to WiFi (static IP, configure router)
- Install v4l2-ctl
- Install binaries from downloads.ase.vu.nl
- Install newer kernel, Niels help?
