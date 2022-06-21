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
   CHIPSET=$(echo "${SENSE}" | grep "Chipset:      \+" | grep -Eo "([\+0-9.]+)")
   CPU=$(echo "${SENSE}" | grep "CPU:          \+" | grep -Eo "([\+0-9.]+)")
   MOTHERBOARD=$(echo "${SENSE}" | grep "Motherboard:" | grep -Eo "([\+0-9.]+)")
   EDGE=$(echo "${SENSE}" | grep "edge" | grep -Eo "([\+0-9.]+)" | head -1)
   JUNC=$(echo "${SENSE}" | grep "junc" | grep -Eo "([\+0-9.]+)" | head -1)
   MEM=$(echo "${SENSE}" | grep "mem" | grep -Eo "([\+0-9.]+)" | head -1)
   JSON=$(echo "{\"chipset\":\"${CHIPSET}\",\"cpu\":\"${CPU}\",\"motherboard\":\"${MOTHERBOARD}\",\"edge\":\"${EDGE}\",\"junc\":\"${JUNC}\",\"mem\":\"${MEM}\"}" | sed 's/ //g')
   echo "$(timestamp) | INFO | $JSON" >> $LOGGING_FILE
   ###TODO
   # Parameterise?
   ###
   sleep 5
done
