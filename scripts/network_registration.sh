#!/bin/bash

# MAC_DB="/home/debix/rover-setup/network/mac_addresses"

debug() {
	echo "🟡 $1"
}

success() {
	echo "✅ $1"
}

error() {
	echo ; echo "❌ $1" ; echo ; exit 1
}

run() {
	$1 || error "failed command: $1"
}

set_hostname() {
	debug "setting hostname to $1"
	# run "sudo hostnamectl set-hostname $1"
}


WIFI_MAC=$(cat /sys/class/net/wlan0/address)
ETHR_MAC=$(cat /sys/class/net/ens33/address)


if [ -z "$WIFI_MAC" ] && [ -z "$ETHER_MAC" ]; then
	error "Could not find mac address of devices: wlan0 and ens33"
fi


CURRENT_HOST_NAME=$(cat /home/debix/rover-setup/network/custom_hostname)
RANDOM_NAME=$(wget -q -O - https://random-word-api.herokuapp.com/word?length=5 | cut -c 3-7)

if [ -z "$CURRENT_HOST_NAME" ]; then

	if [ -n "$RANDOM_NAME" ]; then
		set_hostname $RANDOM_NAME
	else
		set_hostname debix
	fi

else
	set_hostname $CURRENT_HOSTNAME
fi


sleep 1

HOST_NAME=$(hostname)

success "$WIFI_MAC, $ETHR_MAC, $HOST_NAME"

