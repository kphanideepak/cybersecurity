#!/bin/bash

# takes domain address as argument and resolves dns records

#
domain=$1
record_types="A NS MX txt"

for record in $record_types 
do
	#echo $record" "$domain
	if [ "$record" == "A" ]; then
		echo ---- A Records ----
		echo
		nslookup -type=$record $domain
		echo ----- END -----
		echo
	elif [ "$record" == "MX" ]; then
		echo ----- Mail Servers -----
		echo
		nslookup -type=$record $domain | grep 'exchange' | awk '{print $5" "$6}' | sort -n
		echo
		echo --- END of Mail Server Records ---
		echo
	fi
done
