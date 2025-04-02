#!/bin/bash
# vim: nowrap ts=4

# Sysfs setup for ADS1015 ADC

ADC_PATH=/sys/bus/i2c/devices/5-0049/iio:device1

function ads1015_init () {
	# Tell the kernel where our ADC is
	echo ads1015 0x49 | sudo tee /sys/bus/i2c/devices/i2c-5/new_device > /dev/null

	# To remove the driver from the kernel, echo the address to delete_device
	# echo 0x49 | sudo tee /sys/bus/i2c/devices/i2c-5/delete_device > /dev/null
	
	# The ADC can now be found under the Industrial I/O (iio) at the following path, 
	# look there for all the options (sampling_frequency_available, scale_available, input configurations)
	# The lowest sample freq gives the best accuracy, but is slower. That doesn't matter here because we don't read continously.
	# scale_available: 0.125000000 0.250000000 0.500000000 1.000000000 2.000000000 3.000000000
	# sampling_frequency_available=128 250 490 920 1600 2400 3300 3300
	# ADC_PATH=/sys/bus/i2c/devices/5-0049/iio:device1

	# Setup the ADC. 
	# The internal reference voltage is 2.048V, and the resolution is 12-bit for differential inputs, 
	# but we're using them in single-ended mode (one input is ground) so we'll get 11-bit resolution.
	# By selecting a scale of 2, the input range is 4.096V but the actual voltage may not exceed 3.3V, the ADC's supply voltage.
	#
	# CH0 is the potentiometer next to the telemetry module
	# CH0 range: 0 .. 3.3V 
	# CH1 is the potentiometer next to the I2C connectors
	# CH2 is the battery voltage divided by 10
	# CH3 is the external voltage on the white connector between the potentiometers
	#
	# In the end, the raw ADC values are available in in_voltage{0.3}_raw. These have to be calculated to voltages, see below.


	# Set scale for potentiometers, CH0 and CH1
	echo 2 | sudo tee $ADC_PATH/in_voltage0_scale > /dev/null
	echo 2 | sudo tee $ADC_PATH/in_voltage1_scale > /dev/null
	
	# Set scale for VBat/10 (2.048V range is ok here), CH2
	echo 1 | sudo tee $ADC_PATH/in_voltage2_scale > /dev/null
	
	# Set scale for Vext, CH3 (set to scale 2 since we expect the input to be 0 .. 3.3V)
	echo 2 | sudo tee $ADC_PATH/in_voltage3_scale > /dev/null

	# Optionally set the sample frequency
	echo 1600 | sudo tee $ADC_PATH/in_voltage0_sampling_frequency > /dev/null
	echo 1600 | sudo tee $ADC_PATH/in_voltage1_sampling_frequency > /dev/null
	echo 1600 | sudo tee $ADC_PATH/in_voltage2_sampling_frequency > /dev/null
	echo 1600 | sudo tee $ADC_PATH/in_voltage3_sampling_frequency > /dev/null

	# Apparently the ADC or the kernel needs some time to set itself up.
	sleep 1
}

function ads1015_delete () {
	echo 0x49 | sudo tee /sys/bus/i2c/devices/i2c-5/delete_device > /dev/null
}

function ads1015_get_settings () {
	# Read back the settings for verification
	raw0=$(cat $ADC_PATH/in_voltage0_raw)
	raw1=$(cat $ADC_PATH/in_voltage1_raw)
	raw2=$(cat $ADC_PATH/in_voltage2_raw)
	raw3=$(cat $ADC_PATH/in_voltage3_raw)
	echo "CH0: scale=$(cat $ADC_PATH/in_voltage0_scale), sampling_frequency=$(cat $ADC_PATH/in_voltage0_sampling_frequency), raw=$raw0"
	echo "CH1: scale=$(cat $ADC_PATH/in_voltage1_scale), sampling_frequency=$(cat $ADC_PATH/in_voltage1_sampling_frequency), raw=$raw1"
	echo "CH2: scale=$(cat $ADC_PATH/in_voltage2_scale), sampling_frequency=$(cat $ADC_PATH/in_voltage2_sampling_frequency), raw=$raw2"
	echo "CH3: scale=$(cat $ADC_PATH/in_voltage3_scale), sampling_frequency=$(cat $ADC_PATH/in_voltage3_sampling_frequency), raw=$raw3"
}

function ads1015_get_voltages () {
	# To calculate the voltages from the raw value, use the following formula:
	# Vchn = raw * Vref/2^(12-1) * scale

	# In bash, using bc as our calculator this would look like this: (scale=3 is bc's precision and not our ADC scale).
	raw0=$(cat $ADC_PATH/in_voltage0_raw)
	raw1=$(cat $ADC_PATH/in_voltage1_raw)
	raw2=$(cat $ADC_PATH/in_voltage2_raw)
	raw3=$(cat $ADC_PATH/in_voltage3_raw)
	read volt0 <<< "$(bc <<< "scale=3; $raw0 * 2.048/(2^(12-1)) * 2")"
	read volt1 <<< "$(bc <<< "scale=3; $raw1 * 2.048/(2^(12-1)) * 2")"
	read volt2 <<< "$(bc <<< "scale=3; $raw2 * 2.048/(2^(12-1)) * 1 * 10")"	# note ADC scale=1 and x10 for Vbat
	read volt3 <<< "$(bc <<< "scale=3; $raw3 * 2.048/(2^(12-1)) * 2")"
	read percent0 <<< "$(bc <<< "scale=1; 4096/3300 * $raw0 / 2048 * 100")"
	read percent1 <<< "$(bc <<< "scale=1; 4096/3300 * $raw1 / 2048 * 100")"

	echo "CH0_volt="$(printf "%1.3f" $volt0)", CH0_percent=$percent0"
	echo "CH1_volt="$(printf "%1.3f" $volt1)", CH1_percent=$percent1"
	echo "CH2_volt=$volt2"
	echo "CH3_volt=$volt3"
}

# MAIN
if [ "$1" == "init" ]; then
	ads1015_init
	ads1015_get_settings
	exit 0
elif [ "$1" == "delete" ]; then
	ads1015_delete
	exit 0
elif [ "$1" == "getsettings" ]; then
	ads1015_get_settings
	exit 0
elif [ "$1" == "getvoltages" ]; then
	ads1015_get_voltages
	exit 0
else
	echo "Usage: $0 init|delete|getsettings|getvoltages"
	exit 1
fi

