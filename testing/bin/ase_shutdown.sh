#!/bin/bash

# This script runs right before the system shuts down (reboot, poweroff, halt, kexec) if it's put into /usr/lib/systemd/system-shutdown
# It's called with one argument: "halt", "poweroff", "reboot" or "kexec"

PATH="/home/debix/bin:$PATH"

if [ "$1" == "halt" ]; then 
	oled-logo-set logo_noise
	oled-logo-set logo_powered_off
fi

if [ "$1" == "poweroff" ]; then
	oled-logo-set logo_noise
	oled-logo-set logo_powered_off
fi

if [ "$1" == "reboot" ]; then
	oled-logo-set logo_noise
	oled-logo-set logo_reboot
fi

if [ "$1" == "kexec" ]; then
	oled-logo-set logo_noise
	oled-logo-set logo_reboot
fi

