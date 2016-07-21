#!/bin/sh
#
# nyntyl.sh - manipulate current window using 3x3 grid structure
# 

CUR=${3:-$(pfw)}
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)
BW=$(wattr b $CUR)
pad="20"

case $1 in

    th) # throw current window into slot
        X=$pad
        Y=$pad
        W=$((SW/3 - 3*pad/2 - BW))
        H=$((SH/3 - 3*pad/2 - BW))
        case $2 in
            tm) X=$((SW/2 - W/2 - BW)) ;;
            tr) X=$((SW - W - pad - 2*BW)) ;;
            ml) Y=$((SH/2 - H/2 - BW)) ;;
            mm) X=$((SW/2 - W/2 - BW))
                Y=$((SH/2 - H/2 - BW)) ;;
            mr) X=$((SW - W - pad - 2*BW))
                Y=$((SH/2 - H/2 - BW));;
            bl) Y=$((SH - H - pad - 2*BW)) ;;
            bm) X=$((SW/2 - W/2 - BW))
                Y=$((SH - H - pad - 2*BW));;
            br) X=$((SW - W - pad - 2*BW))
                Y=$((SH - H - pad - 2*BW)) ;;
        esac
    
        wtp $X $Y $W $H $CUR ;;

    rs) # resize current window in slot steps
        X=0
        Y=0
        dW=$((SW/3 - 2*BW + 2)) # these offsets are an ugly fiddle
        dH=$((SH/3 - 2*BW + 1)) # but they compensate for int errors
        case $2 in
            h) X=$((-dW)) ;;
            j) Y=$((dH)) ;;
            k) Y=$((-dH)) ;;
            l) X=$((dW)) ;;
        esac
        wrs $X $Y $CUR ;;
esac
