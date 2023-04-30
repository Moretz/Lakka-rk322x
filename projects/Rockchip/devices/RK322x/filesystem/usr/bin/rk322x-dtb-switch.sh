#!/bin/sh

usage() {
	echo "usage: $0 [list|switch|help]"
	echo ""
	echo "      show			show current device tree"
	echo "      list			show available device trees"
	echo "      switch [device tree]	switch to a device tree"
	echo "      help			show this help"
}

show() {
	DTB=`grep FDT /flash/extlinux/extlinux.conf | cut -d '/' -f 2`
	echo "Current device tree is $DTB"
}

list()  {
	for i in `ls -1 /usr/share/bootloader/*.dtb`; 
	do
		echo `basename $i .dtb`
	done
}

switch() {
	if [ ! -e /usr/share/bootloader/$1.dtb ]; then
		echo "Unable to find $1 device tree"
		return 1
	fi
	echo "Device tree $1 founded"
	read -p "Are you sure(y/n)?" yn
	case $yn in
		[Yy])
			echo "Mounting flash rw"
			mount -o remount,rw /flash/
			echo "Switching dtb"
			cp  -f /usr/share/bootloader/$1.dtb /flash/$1.dtb
			sed -i "s/FDT.*/FDT \/$1.dtb/" /flash/extlinux/extlinux.conf
			echo "Mounting flash ro"
			mount -o remount,ro /flash/
			echo "Switching is ok, now you need to reboot!!"
			return 0
			;;
		[Nn])
			return 1
			;;
	esac
	return 1
}

case $1 in
	show)
		show
		exit 0
		;;
	list)
		list
		exit 0
		;;
	switch)
		switch $2
		exit $?
		;;
	help)
		usage
		exit 1
		;;
	*)
		usage
		exit 1
		;;
esac
