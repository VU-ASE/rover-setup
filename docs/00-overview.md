# Overview

We use [Ansible](https://docs.ansible.com/ansible/latest/index.html) to automatically install and configure all necessary software on a freshly built Rover. This repository contains the Ansible tasks as well as any data or code that needs to be copied to each Rover. The following tasks do most of the work:

- `setup.yaml`
    - configures hostname and debix user
    - disables some gnome desktop background services
    - copies the necessary files needed in the `/home/debix` directory
    - makes sure roverd is installed as a daemon as well as necessary directories and files exist
    - 
- `dependencies.yaml` 
    - installs necessary 3rd party apt packages
    - installs `roverlib-c` and `roverlib-python`

In order to automatically install and configure all necessary software on a freshly built Rover 

It uses  to automate the installation procedure in an idempotent way. This means 



