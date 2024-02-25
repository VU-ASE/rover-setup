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

CUSTOM_HOSTNAME=""

set_hostname() {
	debug "setting hostname to $1"
	CUSTOM_HOSTNAME="$1"
	# run "sudo hostnamectl set-hostname $1"
}


WIFI_MAC=$(cat /sys/class/net/wlan0/address)
ETHR_MAC=$(cat /sys/class/net/ens33/address)


if [ -z "$WIFI_MAC" ] && [ -z "$ETHER_MAC" ]; then
	error "Could not find mac address of devices: wlan0 and ens33"
fi

CUSTOM_NAME_PATH="/home/debix/rover-setup/network/custom_hostname"
CURRENT_HOST_NAME=$(cat $CUSTOM_NAME_PATH | xargs)

RANDOM_NAME=$(wget -q -O - https://random-word-api.herokuapp.com/word?length=5 | cut -c 3-7)

if [ -z "$CURRENT_HOST_NAME" ]; then
	if [ -n "$RANDOM_NAME" ]; then
		set_hostname $RANDOM_NAME
	else
		set_hostname debix
	fi

	echo "$CUSTOM_HOSTNAME" > $CUSTOM_NAME_PATH

else
	set_hostname $CURRENT_HOSTNAME
fi



success "$WIFI_MAC, $ETHR_MAC, $CUSTOM_HOSTNAME"

