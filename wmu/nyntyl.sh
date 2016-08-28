#!/bin/sh
#
# nyntyl.sh - manipulate window using 3x3 grid structure
# thanks to /u/wufyy for the refactoring advice

# source global vars
. wmu.conf

# get current window id if not passed as arg
CUR=${3:-$(pfw)}

# grab dimensions of root window
read SW SH <<-eof
	$(wattr wh $(lsw -r))
eof

# grab border width
BW=$(wattr b $CUR)

# leave space for panel
SH=$((SH - PH))

# calculate cell width and height
dW=$((SW/3)) 
dH=$((SH/3))

usage() {
	echo "usage: \n\tthrow:  ${0##*/} <th> <tl|tm|tr|ml|mm|mr|bl|bm|br> \n\tresize: ${0##*/} <rs> <h|j|k|l>"
	exit 1
}

case $1 in

    th) # throw current window into cell
        X=$GAP
		Y=$((PH + GAP))
        W=$((SW/3 - 2*BW - 2*GAP))
        H=$((SH/3 - 2*BW - 2*GAP))
		case ${2#?} in
			m) X=$((dW + GAP)) ;;
			r) X=$((2*dW + GAP)) ;;
		esac
		case ${2%?} in
			m) Y=$((dH + PH + GAP)) ;;
			b) Y=$((2*dH + PH + GAP)) ;;
		esac

        wtp $X $Y $W $H $CUR ;;

    rs) # resize current window in cell steps
        X=0
        Y=0
		read CW CH <<-eof
			$(wattr wh ${CUR})
		eof
        case $2 in
            h) 
				if [ $CW -le $dW ] ; then
					exit 0
				else
					X=$((-dW))
				fi
				;;
            j) 
				Y=$((dH)) 
				;;
            k)
				if [ $CH -le $dH ] ; then
					exit 0
				else
					Y=$((-dH)) 
				fi
				;;
            l) 
				X=$((dW)) 
				;;
        esac

        wrs $X $Y $CUR ;;
	
	*) usage ;;
esac
