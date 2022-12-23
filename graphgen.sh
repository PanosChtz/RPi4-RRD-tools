#!/bin/bash

#Database locations
LOAD_RRD=sysmon.rrd
DISK_RRD=disk.rrd
DISKTEMP_RRD=disktemp.rrd

rrdtool graph load1d.png \
		-Y -u 1.1 -l 0 -L 5 -v "Load" -w 700 -h 200 -t "Load stats - `/bin/date`" \
		-c ARROW\#000000 --x-grid MINUTE:60:HOUR:2:MINUTE:120:0:%R \
		DEF:load1=$LOAD_RRD:load1:AVERAGE \
		DEF:load5=$LOAD_RRD:load5:AVERAGE \
		DEF:load15=$LOAD_RRD:load15:AVERAGE \
		LINE1:load1\#ff0000:"Load average 1 min" \
		LINE1:load5\#ff6600:"Load average 5 min" \
		LINE2:load15\#ffaa00:"Load average 15 min" \
		COMMENT:"	\j" \
		COMMENT:"\j" \
		COMMENT:"	" \
		GPRINT:load15:MIN:"Load 15 min minimum\: %lf" \
		GPRINT:load15:MAX:"Load 15 min maximum\: %lf" \
		GPRINT:load15:AVERAGE:"Load 15 min average\: %lf" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph load1w.png \
		-Y -u 1.1 -l 0 -L 5 -v "Load" -w 700 -h 200 -t "Load stats - `/bin/date`" \
        --start end-"1w" \
		-c ARROW\#000000 \
		DEF:load1=$LOAD_RRD:load1:AVERAGE \
		DEF:load5=$LOAD_RRD:load5:AVERAGE \
		DEF:load15=$LOAD_RRD:load15:AVERAGE \
		LINE1:load1\#ff0000:"Load average 1 min" \
		LINE1:load5\#ff6600:"Load average 5 min" \
		LINE2:load15\#ffaa00:"Load average 15 min" \
		COMMENT:"	\j" \
		COMMENT:"\j" \
		COMMENT:"	" \
		GPRINT:load15:MIN:"Load 15 min minimum\: %lf" \
		GPRINT:load15:MAX:"Load 15 min maximum\: %lf" \
		GPRINT:load15:AVERAGE:"Load 15 min average\: %lf" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph load1h.png \
		-Y -u 1.1 -l 0 -L 5 -v "Load" -w 700 -h 200 -t "Load stats - `/bin/date`" \
        --start end-"1h" --x-grid MINUTE:1:MINUTE:5:MINUTE:10:0:%R \
		-c ARROW\#000000 \
		DEF:load1=$LOAD_RRD:load1:AVERAGE \
		DEF:load5=$LOAD_RRD:load5:AVERAGE \
		DEF:load15=$LOAD_RRD:load15:AVERAGE \
		LINE1:load1\#ff0000:"Load average 1 min" \
		LINE1:load5\#ff6600:"Load average 5 min" \
		LINE2:load15\#ffaa00:"Load average 15 min" \
		COMMENT:"	\j" \
		COMMENT:"\j" \
		COMMENT:"	" \
		GPRINT:load15:MIN:"Load 15 min minimum\: %lf" \
		GPRINT:load15:MAX:"Load 15 min maximum\: %lf" \
		GPRINT:load15:AVERAGE:"Load 15 min average\: %lf" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph temp1h.png \
		-Y -u 1.1 -l 0 -L 5 -v "Temp" -w 700 -h 200 -t "Temp stats - `/bin/date`" \
        --start end-"1h" --lower-limit 45 --x-grid MINUTE:1:MINUTE:5:MINUTE:10:0:%R\
		-c ARROW\#000000 \
		DEF:temp=$LOAD_RRD:cpu_temp:AVERAGE \
		AREA:temp\#fac3c3: \
		LINE1:temp\#aa4556:"CPU Temperature" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph temp1d.png \
		-Y -u 1.1 -l 0 -L 5 -v "Temp" -w 700 -h 200 -t "Temp stats - `/bin/date`" \
        --start end-"1d" --lower-limit 45 --x-grid MINUTE:60:HOUR:2:MINUTE:120:0:%R \
		-c ARROW\#000000 \
		DEF:temp=$LOAD_RRD:cpu_temp:AVERAGE \
		DEF:disktemp=$DISKTEMP_RRD:disk_temp:AVERAGE \
		AREA:temp\#fac3c3: \
		LINE1:temp\#aa4556:"CPU Temperature" \
		LINE2:disktemp\#e9644a:"Disk Temperature" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph temp1w.png \
		-Y -u 1.1 -l 0 -L 5 -v "Temp" -w 700 -h 200 -t "Temp stats - `/bin/date`" \
        --start end-"1w" --lower-limit 45 \
		-c ARROW\#000000 \
		DEF:temp=$LOAD_RRD:cpu_temp:AVERAGE \
		DEF:disktemp=$DISKTEMP_RRD:disk_temp:AVERAGE \
		AREA:temp\#fac3c3: \
		LINE1:temp\#aa4556:"CPU Temperature" \
		LINE2:disktemp\#e9644a:"Disk Temperature" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph mem1h.png \
		-Y -u 1.1 -l 0 -L 5 -v "Memory" -w 700 -h 200 -t "Memory stats - `/bin/date`" \
        --start end-"1h" \
		-c ARROW\#000000 \
		DEF:usedmem=$LOAD_RRD:usedmem:AVERAGE \
		DEF:freemem=$LOAD_RRD:freemem:AVERAGE \
		DEF:buffmem=$LOAD_RRD:buffmem:AVERAGE \
		DEF:availmem=$LOAD_RRD:availmem:AVERAGE \
		DEF:usedsw=$LOAD_RRD:usedsw:AVERAGE \
		DEF:freesw=$LOAD_RRD:freesw:AVERAGE \
		CDEF:relusedmem=usedmem,1000,* \
		CDEF:relfreemem=freemem,1000,* \
		CDEF:relbuffmem=buffmem,1000,* \
		CDEF:relusedsw=usedsw,1000,* \
		CDEF:relfreesw=freesw,1000,* \
		AREA:relusedmem\#ffbfbf:"Used memory" \
		STACK:relbuffmem\#bfbfff:"Buffer memory" \
		STACK:relfreemem\#bbf3b6:"Free memory" \
		LINE1:relusedsw\#eaa4d2:"Used swap memory" \
		LINE1:relusedmem\#ff4d67 \
		STACK:relbuffmem\#4a54df \
		STACK:relfreemem\#40ff40 \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph mem1d.png \
		-Y -u 1.1 -l 0 -L 5 -v "Memory" -w 700 -h 200 -t "Memory stats - `/bin/date`" \
        --start end-"1d" --x-grid MINUTE:60:HOUR:2:MINUTE:120:0:%R  \
		-c ARROW\#000000 \
		DEF:usedmem=$LOAD_RRD:usedmem:AVERAGE \
		DEF:freemem=$LOAD_RRD:freemem:AVERAGE \
		DEF:buffmem=$LOAD_RRD:buffmem:AVERAGE \
		DEF:availmem=$LOAD_RRD:availmem:AVERAGE \
		DEF:usedsw=$LOAD_RRD:usedsw:AVERAGE \
		DEF:freesw=$LOAD_RRD:freesw:AVERAGE \
		CDEF:relusedmem=usedmem,1000,* \
		CDEF:relfreemem=freemem,1000,* \
		CDEF:relbuffmem=buffmem,1000,* \
		CDEF:relusedsw=usedsw,1000,* \
		CDEF:relfreesw=freesw,1000,* \
		AREA:relusedmem\#ffbfbf:"Used memory" \
		STACK:relbuffmem\#bfbfff:"Buffer memory" \
		STACK:relfreemem\#bbf3b6:"Free memory" \
		LINE1:relusedsw\#eaa4d2:"Used swap memory" \
		LINE1:relusedmem\#ff4d67 \
		STACK:relbuffmem\#4a54df \
		STACK:relfreemem\#40ff40 \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph disk1w.png \
		-Y -u 1.1 -l 0 -L 5 -v "Disk" -w 700 -h 200 -t "Disk stats - `/bin/date`" \
        --start end-"1w" --upper-limit 100 --lower-limit 20 --x-grid HOUR:12:DAY:1:DAY:1:0:%a\
		-c ARROW\#000000 \
		DEF:diskfull=$DISK_RRD:disk_full:AVERAGE \
		DEF:diskhealth=$DISK_RRD:disk_health:AVERAGE \
		AREA:diskfull\#e8be49:"Disk usage" \
		LINE2:diskhealth\#ea644a:"Disk health" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph disk1m.png \
		-Y -u 1.1 -l 0 -L 5 -v "Disk" -w 700 -h 200 -t "Disk stats - `/bin/date`" \
        --start end-"1m" --upper-limit 100 --lower-limit 20 --x-grid DAY:1:WEEK:1:WEEK:1:0:%d/%m/%Y\
		-c ARROW\#000000 \
		DEF:diskfull=$DISK_RRD:disk_full:AVERAGE \
		DEF:diskhealth=$DISK_RRD:disk_health:AVERAGE \
		AREA:diskfull\#e8be49:"Disk usage" \
		LINE2:diskhealth\#ea644a:"Disk health" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;

rrdtool graph disk1y.png \
		-Y -u 1.1 -l 0 -L 5 -v "Disk" -w 700 -h 200 -t "Disk stats - `/bin/date`" \
        --start end-"1y" --upper-limit 100 --lower-limit 20 \
		-c ARROW\#000000 \
		DEF:diskfull=$DISK_RRD:disk_full:AVERAGE \
		DEF:diskhealth=$DISK_RRD:disk_health:AVERAGE \
		AREA:diskfull\#e8be49:"Disk usage" \
		LINE2:diskhealth\#ea644a:"Disk health" \
		COMMENT:"	\j" \
		COMMENT:"	" \
		COMMENT:"	\j" >/dev/null;