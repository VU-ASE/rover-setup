#!/bin/bash

i2cbus=5
addr=0x63

reg_input=0x00
reg_psc0=0x01
reg_pwm0=0x02
reg_psc1=0x03
reg_pwm1=0x04
reg_ls0=0x05
reg_ls1=0x06

#set -x

pca_write_reg () {
	i2cset -y $i2cbus $addr $1 $2 
}

pca_read_reg () {
	echo `i2cget -y $i2cbus $addr $1`
}

pca_init () {
	echo "PCA9551 init"
	# LEDS_ENABLE = 0
	pca_write_reg $reg_ls1 0x01
	
	# All leds off, led output disabled
	pca_write_reg $reg_ls1 0x01	# xxxx xx01 = LEDS_ENABLED off
	pca_write_reg $reg_ls0 0x00

	# Setup blink freq
	pca_write_reg $reg_psc0 18	# ~2Hz
	pca_write_reg $reg_psc1 4	# ~10Hz

	# Setup duty cycle
	pca_write_reg $reg_pwm0 0x80	# 50%
	pca_write_reg $reg_pwm1 0x80	# 50%

	# Enable LED outputs (all leds should still be off)
	pca_write_reg $reg_ls1 0x00
}

dec () {
	printf "%d" $1
}


led_left () {
	local err=0
	local val=`pca_read_reg $reg_ls0`
	val=`printf "%d" $val`

	val=$(( $val & `dec 0xcf` ))
	if [ "$1" == "off" ]; then 
		val=$(( val | $((16#00)) ))
	elif [ "$1" == "on" ]; then 
		val=$(( val | $((16#10)) ))
	elif [ "$1" == "pwm0" ]; then
		val=$(( val | $((16#20)) ))
	elif [ "$1" == "pwm1" ]; then
		val=$(( val | $((16#30)) ))
	else 
		err=1
		echo led_left: Error: needs off,on,pwm0 or pwm1 as option
	fi

	if [ err==0 ]; then
		pca_write_reg $reg_ls0 $val
	fi
}

led_right () {
	local err=0
	local val=`pca_read_reg $reg_ls1`	# LS1 reg for blink_right
	val=`printf "%d" $val`

	val=$(( $val & `dec 0x3f` ))
	if [ "$1" == "off" ]; then 
		val=$(( val | $((16#00)) ))
	elif [ "$1" == "on" ]; then 
		val=$(( val | $((16#60)) ))
	elif [ "$1" == "pwm0" ]; then
		val=$(( val | $((16#80)) ))
	elif [ "$1" == "pwm1" ]; then
		val=$(( val | $((16#c0)) ))
	else 
		err=1
		echo led_right: Error: needs off,on,pwm0 or pwm1 as option
	fi

	if [ err==0 ]; then
		pca_write_reg $reg_ls1 $val	# LS1 reg for blink_right
	fi
}


led_emergency () {
	local err=0

	if [ "$1" == "off" ]; then 
		led_left off
		led_right off
	elif [ "$1" == "on" ]; then 
		led_left on
		led_right on
	elif [ "$1" == "pwm0" ]; then
		led_left pwm0
		led_right pwm0
	elif [ "$1" == "pwm1" ]; then
		led_left pwm1
		led_right pwm1
	else 
		err=1
		echo led_emergency: Error: needs off,on,pwm0 or pwm1 as option
	fi
}

led_tail () {
	local err=0
	local val=`pca_read_reg $reg_ls0`
	val=`printf "%d" $val`

	val=$(( $val & `dec 0xf3` ))
	if [ "$1" == "off" ]; then 
		val=$(( val | $((16#00)) ))
	elif [ "$1" == "on" ]; then 
		val=$(( val | $((16#04)) ))
	elif [ "$1" == "pwm0" ]; then
		val=$(( val | $((16#08)) ))
	elif [ "$1" == "pwm1" ]; then
		val=$(( val | $((16#0c)) ))
	else 
		err=1
		echo led_tail: Error: needs off,on,pwm0 or pwm1 as option
	fi

	if [ err==0 ]; then
		pca_write_reg $reg_ls0 $val
	fi
}

led_brake () {
	local err=0
	local val=`pca_read_reg $reg_ls0`
	val=`printf "%d" $val`

	val=$(( $val & `dec 0x3f` ))
	if [ "$1" == "off" ]; then 
		val=$(( val | $((16#00)) ))
	elif [ "$1" == "on" ]; then 
		val=$(( val | $((16#40)) ))
	elif [ "$1" == "pwm0" ]; then
		val=$(( val | $((16#80)) ))
	elif [ "$1" == "pwm1" ]; then
		val=$(( val | $((16#c0)) ))
	else 
		err=1
		echo led_brake: Error: needs off,on,pwm0 or pwm1 as option
	fi

	if [ err==0 ]; then
		pca_write_reg $reg_ls0 $val
	fi
}

led_reverse () {
	local err=0
	local val=`pca_read_reg $reg_ls0`
	val=`printf "%d" $val`

	val=$(( $val & `dec 0xfc` ))
	if [ "$1" == "off" ]; then 
		val=$(( val | $((16#00)) ))
	elif [ "$1" == "on" ]; then 
		val=$(( val | $((16#01)) ))
	elif [ "$1" == "pwm0" ]; then
		val=$(( val | $((16#02)) ))
	elif [ "$1" == "pwm1" ]; then
		val=$(( val | $((16#03)) ))
	else 
		err=1
		echo led_reverse: Error: needs off,on,pwm0 or pwm1 as option
	fi

	if [ err==0 ]; then
		pca_write_reg $reg_ls0 $val
	fi
}


led_off () {
	pca_write_reg $reg_ls0 0
	pca_write_reg $reg_ls1 0
}



if [ "$1" == "no-init" ]; then
	echo Skipping PCA9551 init
else
	pca_init
fi


