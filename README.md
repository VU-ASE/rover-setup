# todo: clean up this repo

<!-- 
# Overview
This repo will install all necessary dependencies and configurations using Ansible and some bash scripts. The flexibility of scripting allows the project to stay consistent with the original [Debix base image](https://debix.io/Software/download.html). For a full tutorial on how to get started with the Debix visit todo-docs-page. The build philosophy behind using scripts is to ensure that we are always compatible with the Debix base image that we don't have control over. This is why we opt to make this installation process compatible as possible such that it will work with any future changes made to the Debix image.

### Getting Started
After booting a new Debix, make sure you are logged in as the default "debix" user, the **installation might not work otherwise**. Simply run the following command in the shell and attend the installation process, it may take some minutes.
``` bash
wget --no-cache -q -O - https://raw.githubusercontent.com/VU-ASE/rover-setup/main/install.sh | sh
```


## TODO
- Connect to WiFi (static IP, configure router)
- Install v4l2-ctl
- Install binaries from downloads.ase.vu.nl
- Install newer kernel, Niels help?


# Steps
* `ansible-galaxy install fubarhouse.golang`
* Inside the ase-dev container run the cross-compile script `cd kernel && ./cross-compile-kernel.sh`

* `cd .. && make`


# Compiling 6.1.22 Kernel with custom configurations
This step involves cross compiling a kernel build from a debix supplied branch https://github.com/debix-tech/linux/tree/Model_AB-L6.1.22.




 -->
