#!/bin/bash

xwin_id=`xdpyinfo | sed -ne 's/^focus:.*\(0x[^,]\+\).*/\1/p'`
if xwininfo -id $xwin_id | grep "(has no name)"
then
    xwin_id=`printf "0x%x\n" $(( $xwin_id - 1 ))` #Decrement by one.
fi

function rofi_get_focus_monitor(){
    ## Get screen info
    screen1=($(xrandr | grep -w connected  | awk -F'[ +]' '{print $1,$3,$4}' |
                   head -n 1))
    screen2=($(xrandr | grep -w connected  | awk -F'[ +]' '{print $1,$3,$4}' |
                   tail -n 1))

    ## Figure out which screen is to the right of which
    if [ ${screen1[2]} -eq 0  ]
    then
        right=(${screen2[@]});
        left=(${screen1[@]});
    else
        right=(${screen1[@]});
        left=(${screen2[@]});

    fi

    ## Get window position
    pos=$(xwininfo -id $(xdotool getactivewindow) | grep "Absolute upper-left X" |
              awk '{print $NF}')

    ## Which screen is this window displayed in? If $pos
    ## is greater than the offset of the rightmost screen,
    ## then the window is on the right hand one
    if [ "$pos" -ge "${right[2]}" ]
    then
        echo "${right[0]}"
    else
        echo "${left[0]}"
    fi
}

rofi -monitor $(rofi_get_focus_monitor) "$@"

# rofi会切换到鼠标所在的屏幕，切换回到之前的窗口
wmctrl -ia $xwin_id