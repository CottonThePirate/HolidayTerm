#!/bin/zsh
# Copyright Chris Schaab 2021  GPLv3
# This script looks a list of holidays, and prints the number of days to
# the next one in the list. If there is a matching ASCII Art file it will
# display the art 
#
#CURRENT ISSUES
#

#zparseopts -A -D 

#File to be used for holiday calculation, must be in the format for the calendar command
CalendarFile="/usr/share/calendar/calendar.usholiday"
ArtFilesDir="./holidayArt"

#FileName Check this mode will go thru all 365 days (to account for leap years) and display the file name
#for every holiday in the calendar file, and if that file appears to exist currently

FileNameCheckMode=0

#Limit the display of ascii art to 1 file so that you don't get something like
#Thanksgiving, christmas, new years, all displaying art at once
artsToDisplay=1
artsDisplayed=0
#
#
#Assign Holidays the next 60 days worth of holidays from CalendarFile, more days takes longer due to the
#many calls to the "date" program to do date math, this is fine on a real computer, but a raspberry pi it will add like 750ms to login

if test "$FileNameCheckMode" -eq 0; then
	daysToCheck=60
else
        daysToCheck=365
fi


###############
#No user variables beyond this point
###############




#zsh Module datetime provides portable date math and other useful items
zmodload zsh/datetime

# Store todays date in seconds (unix time) zsh/datetime provides as EPOCHSECONDS
today=$EPOCHSECONDS


#use tr -d to trim out the * used to designate a holiday without a fixed date (ie 3rd tuesday of march) 

Holidays="$(calendar -A $daysToCheck -f $CalendarFile | tr -d "*" )" 

#echo $Holidays

#go thru our holiday list one by one until we find one with a matching ascii art file

while IFS= read -r line; do
	# The calendar command outputs text as: date <tab> Name of holiday \n 
	# The cut command will split on the tab to seperate the date and the name of the holiday
    DateNum="$(cut -d$'\t' -f 1 <(echo "$line"))"
    DateText="$(cut -d$'\t' -f 2 <(echo "$line"))"
    
    	#Set the artfile to look for name to on alpha numeric chars (no special or spaces)
    ArtFile=${DateText//[^[:alnum:]-]/_}
    
    if test "$FileNameCheckMode" -eq 1; then
	    echo
	    echo "$DateText occurs on $DateNum and looks for the file"
	    echo "$ArtFilesDir/$ArtFile"
    	
	#If there is a file with the same name as the holiday, cat the file
    elif test -f "$ArtFilesDir/$ArtFile" ; then 
	    	#only cat the number of files in artsToDisplay
	    if test "$artsDisplayed" -lt "$artsToDisplay"; then
	    	cat "$ArtFilesDir/$ArtFile"
	    	((artsDisplayed++))
	    fi
    fi
    		#How Many Days until the next Holiday?
		#send errors to the bit bucket because sometimes the date slightly mismatches
    	DateSec="$(strftime -r "%Y %b %d" "2021 $DateNum" )" &>/dev/null
    	daysToHoliday=$(((DateSec - today)/86400))
    	echo "$DateText is $daysToHoliday days away"
    
done < <(printf '%s\n' "$Holidays")
