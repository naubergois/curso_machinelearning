#!/bin/bash
#
# Script to print user information who currently login , current date & time
#
clear
echo "Hello $USER"
echo "Today is ";date
echo "Number of user login : " ; who | wc -l
echo "Calendar"
cal
exit 0
