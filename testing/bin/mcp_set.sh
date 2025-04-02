#!/bin/bash

BUS=5
ADDR=0x21

if [[ ( -z "$1" ) || ( -z "$2" ) ]]; then
	echo Usage: $0 reg val
	exit 1
fi

REG="$1"
VAL="$2"

printf "Reg Wr %02X=%02X, " $REG $VAL
i2cset -y $BUS $ADDR $REG $VAL

printf "Rd=%02X\n" `i2cget -y $BUS $ADDR $REG`

