#!/bin/zsh
# Chris Schaab 2021
# This script looks a list of holidays, and prints the number of days to
# the next one in the list. 


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
