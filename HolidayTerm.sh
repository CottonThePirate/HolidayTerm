#!/bin/zsh
# Chris Schaab 2021
# This script looks a list of holidays, and prints the number of days to
# the next one in the list. 
#
#
# #Calendar File 

debug=1

#File to be used for holiday calculation, must be in the format for the calendar command
CalendarFile="/usr/share/calendar/calendar.usholiday"


# Store todays date in seconds (unix time) in today
today=$(date '+%s')




#Store the next 360 days of holidays into a varb
#I was going to make it less to conserve CPU power, 
#Then realized my $30 rasperry pi that I'm developing on could process them in 
#like 4 ms. Sloppy, but what if someone only wants to celebrate one thing a year? 
	
#Assign Holidays the next 60 days worth of holidays from CalendarFile, 
#us tr -d to trim out the * used to designate a holiday without a fixed date (ie 3rd tuesday of march) 

Holidays="$(calendar -A 60 -f $CalendarFile | tr -d "*" )" 

#debug echo holidays

#echo $Holidays

#go thru our holiday list one by one until we find one with a matching ascii art file

while IFS= read -r line; do
    	#echo "Text read from file: $line"
    DateNum="$(cut -d$'\t' -f 1 <(echo "$line"))"
    DateText="$(cut -d$'\t' -f 2 <(echo "$line"))"
    DateSec=$(date --date=$DateNum '+%s')
    
    	#How Many Days until the next Holiday?
	daysToHoliday=$(((DateSec - today)/86400))
#	if daysToHoliday==0 then
#		echo "Today is $DateText"


    echo "$DateText is $daysToHoliday days away"
done < <(printf '%s\n' "$Holidays")



#July4th=$(date --date=$July4th '+%s')






#for key val in "${(@kv)holidays}"; do
#    echo "$key -> $val"
#    Days2Halloween=$(((NewYears - today) / 86400))
#done
