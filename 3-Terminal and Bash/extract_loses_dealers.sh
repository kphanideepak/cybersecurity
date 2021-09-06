#!/bin/bash

#echo $1



script_name="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

#if [[ $# -eq 0 || $1 -eq "--help" ]]; then
#	echo "error: missing argument."
#	echo Usage: $script_name  [Dates]
#	exit 2
#fi



for ed in  $(awk '{print $1}' loses_times | sort --unique)
do
#	echo
#	echo $ed

# extract loss times
grep -i "$ed" losses_times | awk '{print $2" "$3}' > "$ed"_losstimes;

echo;
#echo "*********** "$1" ***********"

# extract dealers for each games for those times

#for t in $(awk '{print $0}' $1_losstimes); do
	#grep -i "$t" $1_Dealer_schedule
#	echo $t
#done

while read t
do
	grep -i "$t" "$ed"_Dealer_schedule
done < "$ed"_losstimes | awk -F"\t" -v ed="$ed" 'BEGIN{OFS="\t";}{print ed, $1, $3}'; # end of while loop

done # end of for loop
