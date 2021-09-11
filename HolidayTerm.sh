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
ArtFilesDir="./holidayArt"


# Store todays date in seconds (unix time) in today
today=$(date '+%s')


#Assign Holidays the next 60 days worth of holidays from CalendarFile, more days takes longer due to the
#many calls to the "date" program to do date math, this is fine on a real computer, but a raspberry pi it will add like 750ms to login

daysToCheck=60

#use tr -d to trim out the * used to designate a holiday without a fixed date (ie 3rd tuesday of march) 

Holidays="$(calendar -A $daysToCheck -f $CalendarFile | tr -d "*" )" 

#debug echo holidays

#echo $Holidays

#go thru our holiday list one by one until we find one with a matching ascii art file

while IFS= read -r line; do
    	#echo "Text read from file: $line"
    DateNum="$(cut -d$'\t' -f 1 <(echo "$line"))"
    DateText="$(cut -d$'\t' -f 2 <(echo "$line"))"
    DateFirstWord="$(cut -d$' ' -f 1 <(echo "$DateText"))"
    DateSec=$(date --date=$DateNum '+%s')
    if test -f "$ArtFilesDir/$DateFirstWord"; then
	    cat "$ArtFilesDir/$DateFirstWord"
    fi
    
    	#How Many Days until the next Holiday?
    daysToHoliday=$(((DateSec - today)/86400))
    echo "$DateText is $daysToHoliday days away"
done < <(printf '%s\n' "$Holidays")



#July4th=$(date --date=$July4th '+%s')






#for key val in "${(@kv)holidays}"; do
#    echo "$key -> $val"
#    Days2Halloween=$(((NewYears - today) / 86400))
#done
