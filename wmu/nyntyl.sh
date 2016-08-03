#!/bin/sh
#
# nyntyl.sh - manipulate current window using 3x3 grid structure
# 

CUR=${3:-$(pfw)}
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)
BW=$(wattr b $CUR)

SH=$((SH - 14))

dW=$((SW/3)) 
dH=$((SH/3))

case $1 in

    th) # throw current window into slot
        X=0
        Y=0
        W=$((SW/3 - 2*BW))
        H=$((SH/3 - 2*BW))
        case $2 in
            tm) X=$((dW)) ;;
            tr) X=$((2*dW)) ;;
            ml) Y=$((dH)) ;;
            mm) X=$((dW))
                Y=$((dH)) ;;
            mr) X=$((2*dW))
                Y=$((dH));;
            bl) Y=$((2*dH)) ;;
            bm) X=$((dW))
                Y=$((2*dH));;
            br) X=$((2*dW))
                Y=$((2*dH)) ;;
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
esac
