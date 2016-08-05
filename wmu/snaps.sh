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

pad="20"
X=$pad
Y=$pad

case $1 in
    tr) # top-right
		X=$((SW - W - pad - 2*BW)) 
		;;
    bl) # bottom-left
		Y=$((SH - H - pad - 2*BW)) 
		;;
    br) # bottom-right
		X=$((SW - W - pad - 2*BW))
        Y=$((SH - H - pad - 2*BW)) 
		;;
    md) # middle
		X=$((SW/2 - W/2 - BW))
        Y=$((SH/2 - H/2 - BW)) 
		;;
	mm) # venam mode (half screen width && centered)
		W=$((SW/2 - pad - 2*BW))
        X=$((SW/2 - W/2 - BW))    
        H=$((SH - 2*pad - 2*BW))
		;;
    mx) # maximised respecting margins
		W=$((SW - 2*pad - 2*BW))
        H=$((SH - 2*pad - 2*BW))
		;;
	vx) # maximise vertically respecting current origin
		H=$((SH - pad - CY - 2*BW))
		X=$CX
		Y=$CY
		;;
	hx) #maximise horizontally respecting current origin
		W=$((SW - pad - CX - 2*BW))
		X=$CX
		Y=$CY
		;;
esac

wtp $X $Y $W $H $CUR
