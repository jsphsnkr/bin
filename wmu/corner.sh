#! /bin/sh

CUR=${2:-$(pfw)}
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

BW=$(wattr b $CUR)
W=$(wattr w $CUR)
H=$(wattr h $CUR)

pad="20"
X=$pad
Y=$pad

case $1 in
    tr) X=$((SW - W - pad - 2*BW)) ;;
    bl) Y=$((SH - H - pad - 2*BW)) ;;
    br) X=$((SW - W - pad - 2*BW))
        Y=$((SH - H - pad - 2*BW)) ;;
    md) X=$((SW/2 - W/2 - BW))
        Y=$((SH/2 - H/2 - BW)) ;;
    mm) W=$((SW/2 - 2*BW))
        X=$((SW/2 - W/2 - BW))    
        H=$((SH - 2*pad - 2*BW));;
esac

wtp $X $Y $W $H $CUR
