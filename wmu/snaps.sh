#!/bin/sh

#
# snaps.sh - snaps windows to corners, middle, etc.
#

CUR=${2:-$(pfw)}
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

BW=$(wattr b $CUR)
W=$(wattr w $CUR)
H=$(wattr h $CUR)
CX=$(wattr x $CUR)
CY=$(wattr y $CUR)

# panel height
PH="16"

X=0
Y=$PH

case $1 in
    tr) # top-right
		X=$((SW - W - 2*BW)) 
		;;
    bl) # bottom-left
		Y=$((SH - H  - 2*BW)) 
		;;
    br) # bottom-right
		X=$((SW - W - 2*BW))
        Y=$((SH - H - 2*BW)) 
		;;
    md) # middle
		X=$((SW/2 - W/2 - BW))
        Y=$((SH/2 - H/2 - BW)) 
		;;
	mm) # venam mode (half screen width && centered)
		W=$((SW/2 - 2*BW))
        X=$((SW/2 - W/2 - BW))    
        H=$((SH - PH - 2*BW))
		;;
    mx) # maximised respecting panel
		W=$((SW - 2*BW))
        H=$((SH - PH - 2*BW))
		;;
	vx) # maximise vertically to bottom edge
		H=$((SH - CY - 2*BW))
		X=$CX
		Y=$CY
		;;
	hx) #maximise horizontally to right edge
		W=$((SW - CX - 2*BW))
		X=$CX
		Y=$CY
		;;
esac

wtp $X $Y $W $H $CUR
