#!/bin/bash

# Runs on startup/login
# 
# Compton is started. Nitrogen sets a wallpaper. The resolution is set. The dwm bar
# is modified using xsetroot. 
#
# Created Dec 27, 2021 by Hurdensplurgen
# Edited Dec 31, 2021 by Hurdensplurgen
# 	Added updates to dwm bar and changed discription
# Edited Jan 9, 2022 by Hurdensplurgne
# 	Fixed missing unicode character

compton --config ~/.config/compton/compton.conf &
nitrogen --restore &

# sets resolution
xrandr -s 3840x2160

# Modifies dwm bar
while true; do

	# Gets package updates
	upd=`checkupdates | wc -l`

	# Weekday, Month Day Year
	dte="$(date +"%a, %b %d %Y")"

	# HH:MM pm/am
	tme="$(date +"%I:%M %P")"

	# Volume
	vol="$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))"

	# # Percent free of ram
	# mem="$(awk '/^Mem/ {printf("%u%%", 100*$3/$2);}' <(free -m))"

	# Displays updates if there is any, otherwise display everyhting else
	if [ "${upd}" == "0" ]
	then
		xsetroot -name " ${vol} $(printf '\uf028') | ${dte} | ${tme} "
	else
		xsetroot -name " ${upd} $(printf '\uf01a') | ${vol} $(printf '\uf028') | ${dte} | ${tme} "
	fi

	sleep 1s
done &
