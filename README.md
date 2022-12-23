## RRD RPi4 monitoring scripts

This is a set of monitoring tools, tailored for a Raspberry Pi 4 running Ethereum staking software. These are purely Linux scripts, designed to be as lightweight as possible, as a RPi4 staking Ethereum is typically running close to its limits.

###### 1. Prerequisites:

- rrdtool: `sudo apt-get install rrdtool`

* hdsentinel-armv8: https://www.hdsentinel.com/hard_disk_sentinel_linux.php 

###### 2. Create databases:

`rrdtool create disk.rrd --start now --step 3600 --no-overwrite  DS:disk_full:GAUGE:7200:U:U DS:disk_health:GAUGE:7200:U:U  RRA:AVERAGE:0.5:1:8760 RRA:AVERAGE:0.5:24:3650`

`rrdtool create sysmon.rrd --start now --step 60 --no-overwrite DS:load1:GAUGE:120:U:U DS:load5:GAUGE:120:U:U DS:load15:GAUGE:120:U:U DS:cpu_temp:GAUGE:120:U:U DS:usedmem:GAUGE:120:U:U DS:freemem:GAUGE:120:U:U DS:buffmem:GAUGE:120:U:U DS:availmem:GAUGE:120:U:U DS:usedsw:GAUGE:120:U:U DS:freesw:GAUGE:120:U:U RRA:AVERAGE:0.5:1:44640 RRA:AVERAGE:0.5:60:43800`

`rrdtool create disktemp.rrd --start now --step 3600 --no-overwrite  DS:disk_temp:GAUGE:7200:U:U RRA:AVERAGE:0.5:1:8760 RRA:AVERAGE:0.5:24:3650`

###### 3. Setup cron jobs as root: 

`sudo crontab -e`

```
* * * * * /home/user/path-to-script/collect_1m.sh
2 * * * * /home/user/path-to-script/collect_1h.sh
```

## Example output graphs

###### System load

![alt text](https://github.com/PanosChtz/RPi4-RRD-tools/blob/master/graphs/load1d.png?raw=true)

###### Memory usage

![alt text](https://github.com/PanosChtz/RPi4-RRD-tools/blob/master/graphs/mem1d.png?raw=true)

###### CPU and SSD temperature

![alt text](https://github.com/PanosChtz/RPi4-RRD-tools/blob/master/graphs/temp1d.png?raw=true)

###### SSD usage and health

![alt text](https://github.com/PanosChtz/RPi4-RRD-tools/blob/master/graphs/disk1m.png?raw=true)