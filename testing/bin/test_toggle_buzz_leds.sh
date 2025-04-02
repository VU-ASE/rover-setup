#!/bin/bash

$(
	while true; 
	do 
		val=$(cat /sys/class/gpio/gpio12/value)
		if [ "$val" == "0" ]; then 
			sudo gpioset gpiochip5 15=1
			sudo gpioset gpiochip5 2=1
			sleep 0.1
			sudo gpioset gpiochip5 15=0
			sudo gpioset gpiochip5 2=0
			sleep 1
		fi
	 done 
) &


$(
	while true
	do 
		val=$(cat /sys/class/gpio/gpio13/value)
		if [ "$val" == "0" ]; then 
			sudo gpioset gpiochip5 0=0 1=1 2=0 3=1
		else 
			sudo gpioset gpiochip5 0=1 1=0 2=1 3=0
		fi
	sleep 0.25
	done
) &
