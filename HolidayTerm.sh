#!/bin/zsh
# Chris Schaab 2021
# This script looks a list of holidays, and prints the number of days to
# the next one in the list. 
#
#
# #Calendar File 

debug=1

CalendarFile="/usr/share/calendar/calendar.usholiday"

#Store the next 360 days of holidays into a varb
#I was going to make it less to conserve CPU power, 
#Then realized my $30 rasperry pi that I'm developing on could process them in 
#like 4 ms. Sloppy, but what if someone only wants to celebrate one thing a year? 
	
declare -A Holidays

Holidays="$(calendar -A 360 -f $CalendarFile)" 

#echo $Holidays



#holiday Dictionary aka associatve array
#declare -A holidays
#holidays[NewYearsDay]="Jan 1"
#holidays[ValentinesDay]="Feb 14"
#holidays[July4th]="Jul 4"
#holidays[Halloween]="Oct 31"
#holidays[Christmas]="Dec 25"
#holidays[NewYearsEve]="Dec 31"



July4th=$(date --date=$July4th '+%s')


today=$(date '+%s')




for key val in "${(@kv)holidays}"; do
    echo "$key -> $val"
    Days2Halloween=$(((NewYears - today) / 86400))
done
