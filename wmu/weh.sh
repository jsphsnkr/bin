#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# focus a window when it is created
# depends on: wew focus.sh

wew | while IFS=: read ev wid; do
    case $ev in
        # window creation
        16) 
		if ! wattr o $wid; then
			corner.sh md $wid
		fi
		;;

        # occurs on mapping requests
        19) 
		if ! wattr o $wid; then
			focus.sh $wid 
		fi
		;;
        
		# when a window is deleted focus another
		18) 
		if ! wattr $(pfw); then
			focus.sh prev 2>/dev/null
		fi
		
		;;
        
    esac
done
