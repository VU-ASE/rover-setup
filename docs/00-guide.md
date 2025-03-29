# Setup Guide

The following describes how to setup a single Rover. Note, that the automated steps can be run in parallel.

First, download the "Debix-SD-V3.6-20240410.img" from google drive and flash the image onto an SD card with tools like [Balena Etcher](https://etcher.balena.io/). Then, put the SD card into the Rover, attach an ethernet cable to it and turn it on. After some time it should have booted the stock linux Ubuntu that it comes with and it should have an assigned IP address. Find this IP address by going into the Router's settings and finding the new device that has just connected. Let's say we are setting up Rover 7, and find that it is connected with the IP address `192.168.0.183`. Then, we must have the following entry in the `hosts.ini` file:

``` ini
[rover07]
192.168.0.183 ansible_user=debix custom_address=192.168.0.107 rover_id=7 rover_name=turing rover_password=a6caecf790605da0544a71b29fe91f21a44a0ec2d5934d77a06831a7d0afc2fa rover_password_plain=debix servo_trim=0.05
```

The first IP address at the beginning of the line is the address that Ansible will use to connect to the device. The `custom_address` field is the address that the Rover will have at the end of a successful run. This means that after the first run (given that it was successful), we need to change `192.168.0.183` to `192.168.0.107`.

Once this edit has been made, run the following command to check which Rovers are reachable from Ansible:

``` bash
make ping
```

When prompted for the SSH password, enter "debix" and hit enter for the "BECOME" password. This is the password used for running tasks that require root privileges.

If the Rover(s) you are trying to flash respond with a pong, you can proceed with running the entire automation script (zero to hero):

``` bash
make
```

Note: this automation is entirely idempotent and can be run any number of times. However, if some one of the Ansible tasks fails during the setup, then we can run that task in isolation with the following command.

``` bash
make runargs="--tags roverd"
```

This results in running only the set of all tasks that have been tagged with _"roverd"_. This is useful since running the entire zero to hero run can take quite a while.

