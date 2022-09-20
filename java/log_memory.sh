#!/bin/bash

# run sar every hour once in background (forever, kill process manually)
# sar itself creates 60 reports, every 60 seconds one report
LOGFILE="$(date +%Y_%m_%d__%H%M)_memory.log"
for ((;;)); do sar -r 60 60 >> $LOGFILE; sleep 3660; done &
# start java, load SavedModel once and do 1 million inference operations (should take about 24hours)
./gradlew run
