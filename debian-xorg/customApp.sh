#! /bin/bash

if [ "$(cat /proc/device-tree/compatible |grep imx6)" ];then
	echo "Detected imx6..."
	ln -s /etc/X11/xorg.conf.imx6 /etc/X11/xorg.conf
elif [ "$(cat /proc/device-tree/compatible |grep imx7)" ];then
	echo "Detected imx7..."
	ln -s /etc/X11/xorg.conf.imx7 /etc/X11/xorg.conf
else
	echo "Unable to detect hardware. Assuming imx7."
	ln -s /etc/X11/xorg.conf.imx7 /etc/X11/xorg.conf
fi




