#!/bin/bash

TIMESTAMP=$(date +%s)
LOAD_RRD=sysmon.rrd #database location

###CPU LOAD
LOADS=`/bin/cat /proc/loadavg` 
LOAD1_VALUE=${LOADS:0:4} 
LOAD5_VALUE=${LOADS:5:4} 
LOAD15_VALUE=${LOADS:10:4}

###CPU TEMP
READ_TEMP=$(/usr/bin/vcgencmd measure_temp)
TEMP_VALUE=${READ_TEMP:5:4}

###MEMORY
{
read x
read x memtotal USED_MEM_VALUE FREE_MEM_VALUE memshared BUFF_MEM_VALUE AVAIL_MEM_VALUE x
read x swptotal USEDSW_MEM_VALUE FREESW_MEM_VALUE x
} < <( free -m )

rrdtool update $LOAD_RRD ${TIMESTAMP}:${LOAD1_VALUE}:${LOAD5_VALUE}:${LOAD15_VALUE}:${TEMP_VALUE}:${USED_MEM_VALUE}:${FREE_MEM_VALUE}:${BUFF_MEM_VALUE}:${AVAIL_MEM_VALUE}:${USEDSW_MEM_VALUE}:${FREESW_MEM_VALUE}
