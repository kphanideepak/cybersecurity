#!/bin/bash

#########################################################################
# This script is to find Roulette dealer at a given date and time  	#
# Author: Phil Kalluri							#
# date: 27th June 2021							#
# email: phil@kalluriit.com.au						#
#########################################################################

script_name="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

if [[ $# -ne 3 || $1 -eq "--help" ]]; then
       	echo "error: missing argument."
       	echo USAGE: $script_name  [DDMM] [HH:MM:SS] [AM/PM]
	echo EX: $script_name 0310 12:00:00 AM
       	exit 2
fi


d=$1 #date
tm=$2 #time
m=$3 #am/pm


# echo -e "Time\tDealer"

# the below approach would work but needs two commands to get the required output
# awk -F"\t" '{print $1,$3}' "$d"_Dealer_schedule | grep -i "$2" 
#awk -F"\t" '/"$tm"/{print $1,$3}' "$d"_Dealer_schedule 
#awk -F"\t" -v tm="$tm" '/tm/{print $1,$3}' "$d"_Dealer_schedule 

# awk -F"\t" -v dealertime="$tm $m" 'BEGIN{OFS="\t";print "Time","Dealer"} $0~dealertime{print $1,$3}' "$d"_Dealer_schedule
echo -n $d-

# in the blow command, $0 ~ is used to check if any line have the given dealer time.

awk -F"\t" -v dealertime="$tm $m" '$0~dealertime{print $1,$3}' "$d"_Dealer_schedule

