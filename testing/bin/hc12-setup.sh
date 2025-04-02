#!/bin/bash

# Serial port 
PORT=/dev/ttymxc2

# Channel number. 1..127 but >100 not recommended. Also see HC12 doc for channel spacing (5?)
# So valid channels would be 1, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61, 66, 71, 76, 81, 86, 91 and 96.
CHANNEL=21		

# Communication baudrate
BAUD=115200

hc12_send () {
	echo "hc12_send(): $1"
	echo -n $1 > $PORT
	hc12_receive
}

hc12_receive () {
	read -t2 RESP < $PORT
	echo -n "hc12_receive(): "
	if [ -z "$RESP" ]; then
		echo no response
	else
		echo "$RESP"
	fi
}

# Setup GPIO pin for command mode (GPIO3_IO21 (85) according to debix-gpio but the schematic says GPIO1_IO21),
# and enter HC12 command mode by setting the pin to 0
hc12_set () {
	if [ ! -d /sys/class/gpio/gpio85 ]; then
		echo "hc12_set(): exporting pin 85"
		echo 85  > /sys/class/gpio/export
	else 
		echo "hc12_set(): pin 85 already exported"
	fi

	echo out > /sys/class/gpio/gpio85/direction 
	echo 0   > /sys/class/gpio/gpio85/value
}

hc12_unset () {
	echo 1   > /sys/class/gpio/gpio85/value
	echo 85  > /sys/class/gpio/unexport
}


# Enter HC12 command mode 
#debix-gpio GPIO3_IO21 out 0
hc12_set

# Set baudrate to 9600 (command mode is always 9600)
stty -F $PORT raw speed 9600 > /dev/null

# Show current settings
hc12_send "AT+V" 	# Firmware version
hc12_send "AT+RB"	# Get baudrate
hc12_send "AT+RC"	# Get channel
hc12_send "AT+RF"	# Get transmission mode
hc12_send "AT+RP"	# Get transmission power level

# Reset to default settings
hc12_send "AT+DEFAULT"

# Set baudrate
hc12_send "AT+B$BAUD" 

# Set channel 
HC12_CH=`printf "%03i" $CHANNEL`	# Format channel number
hc12_send "AT+C$HC12_CH"

# Set transmission mode
hc12_send "AT+FU3"

# Set transmitting power level (8=max, 20dBm)
hc12_send "AT+P8"

# Show new settings
hc12_send "AT+RX"

# Exit HC12 command mode 
#debix-gpio GPIO3_IO21 out 1
hc12_unset

# Set baudrate to specified communication speed 
stty -F $PORT raw speed $BAUD > /dev/null

