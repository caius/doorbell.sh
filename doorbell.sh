#!/bin/bash

[[ "$TRACE" ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

while :
do
  echo "Listening for press"
  # Wait for GPIO pin to go high
  gpio -g wfi 17 rising

  echo "Doorbell Ring Started"
  mosquitto_pub -h mqtt1 -t stat/front-door/RING -m ON
  sleep 0.5 
  mosquitto_pub -h mqtt1 -t stat/front-door/RING -m OFF

  # Fake debouncing, only allow triggering every ~10 seconds
  sleep 10
  echo "Doorbell Ring Finished"
done
