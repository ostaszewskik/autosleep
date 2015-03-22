#!/bin/bash
#
# This is scheduled in CRON.  It will run every 20 minutes
# and check for inactivity.  It compares the RX and TX packets
# from 20 minutes ago to detect if they significantly increased.
# If they haven't, it will force the system to sleep.
#

log=~/Scripts/idle/log

# Extract the RX/TX
rx=`/sbin/ifconfig eth0 | grep -m 1 RX | cut -d: -f2 | sed 's/ //g' | sed 's/errors//g'`
tx=`/sbin/ifconfig eth0 | grep -m 1 TX | cut -d: -f2 | sed 's/ //g' | sed 's/errors//g'`

#Write Date to log
date >> $log
echo "Current Values" >> $log
echo "rx: "$rx >> $log
echo "tx: "$tx >> $log

# Check if RX/TX Files Exist
if [ -f ~/Scripts/idle/rx ] || [ -f ~Scripts/idle/tx ]; then
	p_rx=`cat ~/Scripts/idle/rx`  ## store previous rx value in p_rx
	p_tx=`cat ~/Scripts/idle/tx`  ## store previous tx value in p_tx
	
	echo "Previous Values" >> $log
	echo "p_rx: "$p_rx >> $log
	echo "t_rx: "$p_tx >> $log

	echo $rx > ~/Scripts/idle/rx    ## Write packets to RX file
	echo $tx > ~/Scripts/idle/tx    ## Write packets to TX file
	
	# Calculate threshold limit 
	t_rx=`expr $p_rx + 1000`
	t_tx=`expr $p_tx + 1000`

	echo "Threshold Values" >> $log
	echo "t_rx: "$t_rx >> $log
	echo "t_tx: "$t_tx >> $log
	echo " " >> $log
	 
	if [ $rx -le $t_rx ] || [ $tx -le $t_tx ]; then  ## If network packets have not changed that much
		echo "Suspend to Ram ..." >> $log
		echo " " >> $log
		rm ~/Scripts/idle/rx
		rm ~/Scripts/idle/tx
		sudo pm-suspend  ## Force Sleep
	fi
	
#Check if RX/TX Files Doesn't Exist
else 
	echo $rx > ~/Scripts/idle/rx ## Write packets to file
	echo $tx > ~/Scripts/idle/tx
	echo " " >> $log
fi 
