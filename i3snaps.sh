#!/bin/sh

#
# i3snaps.sh - snaps windows to corners, middle, etc.
#

PH=16
GAP=8
BW=2

CUR=${2:-$(pfw)}
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

#BW=$(wattr b $CUR)
W=$(wattr w $CUR)
H=$(wattr h $CUR)
CX=$(wattr x $CUR)
CY=$(wattr y $CUR)

X=$((GAP + BW))
Y=$((PH + GAP + BW))

case $1 in
    tr) # top-right
		X=$((SW - W - BW - GAP)) 
		;;
    bl) # bottom-left
		Y=$((SH - H  - BW - GAP)) 
		;;
    br) # bottom-right
		X=$((SW - W - BW - GAP))
        Y=$((SH - H - BW - GAP)) 
		;;
    md) # middle
		X=$((SW/2 - W/2 - BW))
		Y=$((SH/2 - H/2 + PH/2)) 
		;;
	mm) # venam mode (half screen width && centered)
		W=$((SW/2 - 2*BW - GAP))
        X=$((SW/2 - W/2 - BW))    
        H=$((SH - PH - 2*BW - 2*GAP))
		;;
    mx) # maximised respecting panel
		W=$((SW - 2*BW - 2*GAP))
        H=$((SH - PH - 2*BW - 2*GAP))
		;;
esac

wtp $X $Y $W $H $CUR
