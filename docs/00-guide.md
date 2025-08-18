# Setup Guide

The following describes how to setup a single Rover. Note, that it can be applied to any number of rovers in parallel to speed up the automation process.

First, download the "Debix-SD-V3.6-20240410.img" from the google drive or the debix website and flash the image onto an SD card with tools like [Balena Etcher](https://etcher.balena.io/). Then, put the SD card into the Rover, attach an ethernet cable to it and turn it on. After some time it should have booted the stock linux Ubuntu that it comes with and it should have an assigned IP address. Find this IP address by going into the Router's settings and finding the new device that has just connected. Let's say we are setting up Rover 7, and find that it is connected with the IP address `192.168.0.183`. Then, we must have the following entry in the `hosts.ini` file:

``` ini
[rover07]
192.168.0.183 ansible_user=debix rover_id=7 rover_name=turing rover_password=a6caecf790605da0544a71b29fe91f21a44a0ec2d5934d77a06831a7d0afc2fa rover_password_plain=debix servo_trim=0.05
```

The first IP address at the beginning of the line is the address that Ansible will use to connect to the device (the one assigned by the router `...183`). Since we use mDNS to connect to the rovers using their hostnames, we don't *need* to remember IP addresses like `192.168.0.183`, we can just remember `rover07.local`. If however there are mDNS connection issues, then we must resort to connecting with the IP directly. In theory, after a successful run of the automation the Rover will be available at the `rover07.local` address which means we could change the IP address at the start of the line from `192.168.0.183` -> `rover07.local`. This is recommended since the router might assign it a different IP address some day.

Then, we can use the following command to make sure we can access all of the rovers.

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

