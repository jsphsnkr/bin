#! /bin/sh
## grabsolours.sh ( from colr by dkeg )
## thanks dkeg!

colors() {
    bg=$(xrdb -query | grep "background" | cut -d '#' -f2)
    fg=$(xrdb -query | grep "foreground" | cut -d '#' -f2)
    blk=$(xrdb -query | grep "color0:" | cut -d '#' -f2)
    red=$(xrdb -query | grep "color1:" | cut -d '#' -f2)
    grn=$(xrdb -query | grep "color2:" | cut -d '#' -f2)
    ylw=$(xrdb -query | grep "color3:" | cut -d '#' -f2)
    blu=$(xrdb -query | grep "color4:" | cut -d '#' -f2)
    mag=$(xrdb -query | grep "color5:" | cut -d '#' -f2)
    cyn=$(xrdb -query | grep "color6:" | cut -d '#' -f2)
    wht=$(xrdb -query | grep "color7:" | cut -d '#' -f2)
    bblk=$(xrdb -query | grep "color8:" | cut -d '#' -f2)
    bred=$(xrdb -query | grep "color9:" | cut -d '#' -f2)
    bgrn=$(xrdb -query | grep "color10:" | cut -d '#' -f2)
    bylw=$(xrdb -query | grep "color11:" | cut -d '#' -f2)
    bblu=$(xrdb -query | grep "color12:" | cut -d '#' -f2)
    bmag=$(xrdb -query | grep "color13:" | cut -d '#' -f2)
    bcyn=$(xrdb -query | grep "color14:" | cut -d '#' -f2)
    bwht=$(xrdb -query | grep "color15:" | cut -d '#' -f2)
  }

fonts() {
    fnt=$(xrdb -query | grep "*.font" | cut -d ':' -f 3-)
    if [ -z "$fnt" ] 
        then
            fnt=$(xrdb -query | grep "*.font" | cut -d ':' -f2)
           # fnt="${var//[[:space:]]/}"
    fi
}

fonts
colors
