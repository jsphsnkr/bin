#! /bin/sh
#
# z3bra - 2014 (c) wtfpl
# focus a window when it is created
# depends on: wew focus.sh

wew | while IFS=: read ev wid; do
    case $ev in
        # window creation: center if not dock etc
        16) wattr o $wid || nyntyl.sh th mm $wid ;;
        # occurs on mapping requests
        19) wattr o $wid || focus.sh $wid ;;
        # when a window is deleted focus another
        18) wattr $(pfw) || focus.sh prev 2>/dev/null;;
        # focus window on mouse entry
        #7) wattr o $wid || focus.sh $wid ;;
    esac
done
