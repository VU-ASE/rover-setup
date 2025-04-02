#!/bin/bash

source rearlightassy-cmd.sh no-init

test_led_left () {
	led_left pwm0
	sleep 4
	led_left off
	sleep 1
}

test_led_right () {
	led_right pwm0
	sleep 4
	led_right off
	sleep 1
}

test_led_emergency () {
	led_emergency pwm0
	sleep 4
	led_emergency off
	sleep 1
}

test_led_tail_brake () {
	led_tail on
	sleep 4
	led_brake on
	sleep 4
	led_tail pwm1
	led_brake pwm1
	sleep 4
	led_tail off
	led_brake off
	sleep 1
}

test_led_reverse () {
	led_reverse on
	sleep 4
	led_reverse off
	sleep 1
}

test_led_disco () {
	led_left on
	led_right on
	sleep 2
	led_emergency pwm0
	sleep 2
	led_emergency pwm1
	sleep 2
	led_left pwm1
	led_right pwm0
	led_tail pwm0
	led_brake pwm1
	led_reverse pwm0
	sleep 4
	
	led_left off
	led_right off
	led_tail off
	led_brake off
	led_reverse off
}



pca_init

test_led_left
test_led_right
test_led_emergency
test_led_tail_brake
test_led_reverse
test_led_disco

led_off

