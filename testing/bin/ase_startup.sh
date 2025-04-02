#!/bin/bash
# vim: ts=4

PATH="/home/debix/bin:$PATH"

function gpioset () {
	n="$1"
	dir="$2"
	val="$3"
	echo $n   | sudo tee /sys/class/gpio/export > /dev/null
	echo $dir | sudo tee /sys/class/gpio/gpio$n/direction > /dev/null 
	if [ ! -z "$val" ]; then
		echo $val | sudo tee /sys/class/gpio/gpio$n/value > /dev/null
	fi
}


# Configure CAN1/CAN2 pins for GPIO
n=86
echo $n  > /sys/class/gpio/export            
echo out > /sys/class/gpio/gpio$n/direction  
echo 0   > /sys/class/gpio/gpio$n/value      

n=87
echo $n  > /sys/class/gpio/export            
echo out > /sys/class/gpio/gpio$n/direction  
echo 0   > /sys/class/gpio/gpio$n/value      

n=88
echo $n  > /sys/class/gpio/export            
echo out > /sys/class/gpio/gpio$n/direction  
echo 0   > /sys/class/gpio/gpio$n/value      

n=89
echo $n  > /sys/class/gpio/export            
echo out > /sys/class/gpio/gpio$n/direction  
echo 0   > /sys/class/gpio/gpio$n/value      

# Configure HC12 SET pin
#hc12-setup.sh
n=85
echo $n  > /sys/class/gpio/export            
echo out > /sys/class/gpio/gpio$n/direction  
echo 1   > /sys/class/gpio/gpio$n/value      
stty -F /dev/ttymxc2 speed 9600 raw 

# Switches and LEDs on GPIO
n=3	# Blue LED
echo $n  > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio$n/direction
echo 0   > /sys/class/gpio/gpio$n/value

n=4 # Yellow LED
echo $n  > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio$n/direction
echo 0   > /sys/class/gpio/gpio$n/value

n=12 # Toggle switch
echo $n  > /sys/class/gpio/export
echo in > /sys/class/gpio/gpio$n/direction

n=13 # Pushbutton
echo $n  > /sys/class/gpio/export
echo in > /sys/class/gpio/gpio$n/direction
####
#### # Switches and LEDs on MCP23017
#### echo mcp23017 0x21 | sudo tee /sys/bus/i2c/devices/i2c-5/new_device > /dev/null
#### #### # No exports yet here, gpiod (gpioset / gpioget) work fine
pca9555_init.sh
i2cset -y 5 0x21 0x02 0x01; sleep 0.05; i2cset -y 5 0x21 0x02 0x00
i2cset -y 5 0x21 0x03 0xf0; sleep 1; i2cset -y 5 0x21 0x03 0x00
