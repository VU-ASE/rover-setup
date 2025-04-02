#!/bin/bash

PATH=/home/debix/bin:$PATH

oled-logo-set logo_clear 
sleep 1
for i in logo_vukip logo_nxp logo_debix logo_duckcover logo_ase 
do 
	oled-logo-set $i 
	sleep 1
done
