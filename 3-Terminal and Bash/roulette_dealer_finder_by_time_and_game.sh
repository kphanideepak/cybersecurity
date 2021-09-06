#!/bin/bash

#########################################################################
# This script is to find Roulette dealer at a given date and time for a	#
# game  								#
# Author: Phil Kalluri							#
# date: 27th June 2021							#
# email: phil@kalluriit.com.au						#
#########################################################################

script_name="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

RED='\033[0;31m'

NC='\033[0m' # No Color

if [[ $# -ne 3 || $1 -eq "--help" ]]; then
       	echo -e "$(tput setaf 1)Error:$NC missing argument(s)."
       	echo -e $(tput setaf 3)USAGE:$NC $script_name  [DDMM] [HH:MM:SS AM] [$(tput setaf 2)BJ$NC - Black Jack OR $(tput setaf 2)RO$NC - Roulette OR $(tput setaf 2)TH$NC - Texas Hold]
	echo -e $(tput setaf 3)example usage:$NC 
	echo -e "\t"$script_name 0310 \'12:00:00 AM\' 1
	echo -e "\t"$script_name 0310 \'12:00:00 AM\' bj
	echo -e "\t"$script_name 0310 \'12:00:00 AM\' BJ
	echo -e "\t"$script_name 0310 \'12:00:00 AM\' Bj
	echo -e "\t"$script_name 0310 \'12:00:00 AM\' B
	echo -e "\t"$script_name 0310 \'12:00:00 AM\' b
       	exit 2
fi

d=$1
tm=$2
case $3 in
	[Bb] | [Bb][Jj] | 1)
		game="Black Jack";
		gcol=2;
		;;
	[Rr] | [Rr][Oo] | 2)
		game="Roulette";
		gcol=3;
		;;
	[Tt] | [Tt][Hh] | 3)
		game="Texas Hold Em";
		gcol=4;
		;;
	*)
		game="Roulette";
		gcol=3;
		;;
esac

 echo game is $game
# echo gcol is $gcol

# echo -e "Time\tDealer"

# the below approach would work but needs two commands to get the required output
# awk -F"\t" '{print $1,$3}' "$d"_Dealer_schedule | grep -i "$2" 
#awk -F"\t" '/"$tm"/{print $1,$3}' "$d"_Dealer_schedule 
#awk -F"\t" -v tm="$tm" '/tm/{print $1,$3}' "$d"_Dealer_schedule 

awk  -F"\t" -v dealerTime="$tm" -v gameCol="$gcol" -v gameName="$game" 'BEGIN{OFS="\t";print "Time","Game","Dealer"} $0~dealerTime{print $1,gameName,$gameCol}' "$d"_Dealer_schedule
