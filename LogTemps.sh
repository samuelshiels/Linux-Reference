#!/bin/bash

###TODO
# Parameterise?
# Set in a config file?
###
LOGGING_FILE="temps.log"

#Define a function to generate a timestamp in the ISO-8601 format
###TODO
# Move to its own script to reference?
# Could use date -Iseconds ?
###
timestamp() {
  date +"%Y-%m-%dT%H:%M:%S%:z" # current time
}
timestamp
echo "$(timestamp) | INFO | temperature logging started" >> $LOGGING_FILE

#Uses 'sensors' command to acquire information from system sensors
# Outputs in a standard log file format set by the logging file. The information in the log entry is a JSON represenation of the extracted data from sensors.
###TODO
# Parameterise?
# Set in a config file?
###
while [ true ]
   do
   SENSE=$(sensors)
   CHIPSET=$(echo "${SENSE}" | grep "Chipset:      \+")
   CPU=$(echo "${SENSE}" | grep "CPU:          \+")
   MOTHERBOARD=$(echo "${SENSE}" | grep "Motherboard:")
   EDGE=$(echo "${SENSE}" | grep "edge")
   JUNC=$(echo "${SENSE}" | grep "junc")
   MEM=$(echo "${SENSE}" | grep "mem")
   echo "$(timestamp) | INFO | {\"chipset\":\"${CHIPSET}\",\"cpu\":\"${CPU}\",\"motherboard\":\"${MOTHERBOARD}\",\"edge\":\"${EDGE}\",\"junc\":\"${JUNC}\",\"mem\":\"${MEM}\"}" >> $LOGGING_FILE
   ###TODO
   # Parameterise?
   ###
   sleep 5
done
