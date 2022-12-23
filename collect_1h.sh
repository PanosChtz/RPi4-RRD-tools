#!/bin/bash

TIMESTAMP=$(date +%s)
DISK_RRD=disk.rrd #disk database location
DISKTEMP_RRD=disktemp.rrd #disk temp database location

###DISK USAGE
READ_DISKUSG=$(df -hP /dev/sda2 | awk '{print $5}' |tail -1|sed 's/%$//g')
DISKUSG_VALUE=${READ_DISKUSG}

DISKHLTH_DATA=$(/home/user/hdsentinel-armv8) #change for hdsentinel binary location

###DISK HEALTH
READ_DISKHLTH=$(echo "$DISKHLTH_DATA" | grep "Health" | awk '{print $3}')
DISKHLTH_VALUE=${READ_DISKHLTH}
rrdtool update $DISK_RRD ${TIMESTAMP}:${DISKUSG_VALUE}:${READ_DISKHLTH}

###DISK TEMP
READ_DISKTEMP=$(echo "$DISKHLTH_DATA" | grep "Temperature" | awk '{print $3}')
DISKTEMP_VALUE=${READ_DISKTEMP}
rrdtool update $DISKTEMP_RRD ${TIMESTAMP}:${DISKTEMP_VALUE}