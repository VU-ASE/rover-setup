#!/bin/bash

while true; do
	# Toggle switch and LED blue
	GPIO12=$(cat /sys/class/gpio/gpio12/value)
	echo $GPIO12 > /sys/class/gpio/gpio3/value

	# Pushbutton switch and LED yellow
	GPIO13=$(cat /sys/class/gpio/gpio13/value)
	echo $GPIO13 > /sys/class/gpio/gpio4/value
	echo 

	echo SW_Toggle=$GPIO12, SW_PUSH=$GPIO13
	sleep 0.25
done
