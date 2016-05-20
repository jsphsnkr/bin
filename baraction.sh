#! /bin/bash
# baraction.sh script for spectrwm status bar

SLEEP=5
COUNT=0

while :; do
        let COUNT=$COUNT+1
        echo -e "         Hello World! $COUNT"
        sleep $SLEEP
done
