
#!/bin/sh

userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
#sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if lspci | grep "VirtualBox" ; then
    vganame=$(xrandr | sed '1d' | sed '2,$d' | awk '{print $1}')
    newmodecmd=$(cvt 1000 600 | sed "1d" | awk '{print "xrandr --newmode "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13}')
#    newmodecmd=$(cvt 1280 730 | sed "1d" | awk '{print "xrandr --newmode "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13}')
    modename=$(eval echo $(echo $newmodecmd | awk '{print $3}'))
    if xrandr | grep $modename; then
        echo
    else
        eval $newmodecmd
        xrandr --addmode $vganame $modename
    fi
    xrandr --output $vganame --mode $modename
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

fcitx
#xfce4-notifyd &
#nm-applet &
#xfce4-panel --disable-wm-check &
#xter -geometry 80x66+0+0 -fg grey -bg black -name login &

