#!/bin/bash

# export gpio
n=12
echo $n  > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio$n/direction
echo 0   > /sys/class/gpio/gpio$n/value

n=13
echo $n  > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio$n/direction
echo 0   > /sys/class/gpio/gpio$n/value

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
stty -F /dev/ttymxc2 speed 115200 raw

