#!/bin/bash

#########################################################################
# This script is to clean the input data and player analysis  	#
# Author: Phil Kalluri							#
# date: 27th June 2021							#
# email: phil@kalluriit.com.au						#
#########################################################################

echo "***** Player Data Analysis *****" > Notes_Player_Analysis
echo >> Notes_Player_Analysis
echo "***** Losses each day *****" >> Notes_Player_Analysis
echo | awk 'BEGIN{OFS="\t"}{print "Date","Time. of Loss"}' >> Notes_Player_Analysis
grep -i '-' 0310* | awk 'BEGIN{OFS="\t"}{print "0310",$1" "$2}' >> Notes_Player_Analysis
grep -i '-' 0312* | awk 'BEGIN{OFS="\t"}{print "0312",$1" "$2}' >> Notes_Player_Analysis
grep -i '-' 0315* | awk 'BEGIN{OFS="\t"}{print "0315",$1" "$2}' >> Notes_Player_Analysis
echo >> Notes_Player_Analysis

grep -i '-' 0310* | awk 'BEGIN{OFS="\t"}{print "0310",$1" "$2}' > loss_times
grep -i '-' 0312* | awk 'BEGIN{OFS="\t"}{print "0312",$1" "$2}' >> loss_times
grep -i '-' 0315* | awk 'BEGIN{OFS="\t"}{print "0315",$1" "$2}' >> loss_times


# generating the list of losses and the players invloved in each incident
# cleaning up the input data for easier processing
grep -i '-' 03* | sed -E 's/ /!/g' | sed -E 's/,!/,/g' | sed 's/\([!]\)\1\+/\t/g' | sed 's/!/ /g' |sed 's/[\t ]$//g' | sed 's/, /,/g' | sed 's/ ,/,/g' > Roulette_Losses
echo  There were a total of $(cat Roulette_Losses | wc -l) incidents of losses over the given dates >> Notes_Player_Analysis

echo >> Notes_Player_Analysis
echo Listing the top 5 duplicates from the player list >> Notes_Player_Analysis
awk -F'\t' 'BEGIN{ORS=","}{print $3}' Roulette_Losses | awk 'BEGIN{RS=","}{names[$0]++;}END{for (name in names) print names[name], name}' | sort -nr | head -5 >> Notes_Player_Analysis
awk -F'\t' 'BEGIN{ORS=","}{print $3}' Roulette_Losses | awk 'BEGIN{RS=","}{names[$0]++;}END{for (name in names) print names[name], name}' | sort -nr | head -1 | awk '{print $2" "$3,"seems to be playing",$1,"times"}' >> Notes_Player_Analysis
