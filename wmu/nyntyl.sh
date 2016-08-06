#!/bin/sh
#
# nyntyl.sh - manipulate window using 3x3 grid structure
# 

# get current window id if not passed as arg
CUR=${3:-$(pfw)}

# grab root id and dimensions
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

# grab border width
BW=$(wattr b $CUR)

# panel height
PH=20

# leave space for panel
SH=$((SH - PH))

# calculate cell width and height
dW=$((SW/3)) 
dH=$((SH/3))

usage() {
	echo "usage: \n\tthrow:  $(basename $0) <th> <tl|tm|tr|ml|mm|mr|bl|bm|br> \n\tresize: $(basename $0) <rs> <h|j|k|l>"
	exit 1
}

case $1 in

    th) # throw current window into slot
        X=0
        Y=$PH
        W=$((SW/3 - 2*BW))
        H=$((SH/3 - 2*BW))
        case $2 in
            tm) X=$((dW)) ;;
            tr) X=$((2*dW)) ;;
            ml) Y=$((dH + PH)) ;;
            mm) X=$((dW))
                Y=$((dH + PH)) ;;
            mr) X=$((2*dW))
                Y=$((dH + PH));;
            bl) Y=$((2*dH + PH)) ;;
            bm) X=$((dW))
                Y=$((2*dH + PH));;
            br) X=$((2*dW))
                Y=$((2*dH + PH)) ;;
        esac
    
        wtp $X $Y $W $H $CUR ;;

    rs) # resize current window in slot steps
        X=0
        Y=0
        
        case $2 in
            h) X=$((-dW)) ;;
            j) Y=$((dH)) ;;
            k) Y=$((-dH)) ;;
            l) X=$((dW)) ;;
        esac
        wrs $X $Y $CUR ;;
	
	*) usage ;;
esac
