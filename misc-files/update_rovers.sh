#!/bin/bash

function check_roverd {
    status=`curl -s localhost/status | jq -r '.status'`

    if [ "$status" != "operational" ] ; then
        echo Error: roverd not operational;
        exit 1;
    fi
}

function get_service {
    curl -u debix:debix \
        -X 'POST' \
        'http://localhost/fetch' \
        -H 'accept: application/json' \
        -H 'Content-Type: application/json' \
        -d '{"url": "https://github.com/VU-ASE/$1/releases/latest/download/$1.zip"}'
}

check_roverd

get_service imaging
get_service controller
get_service actuator
get_service transceiver
