if false; then
echo "!!!!!!!!!!!!!!!!!"
echo "!!             !!"
echo "!! SUMMER TODO !!"
echo "!!             !!"
echo "!!             !!"
echo "!!             !!"
echo "!!             !!"
echo "!!             !!"
echo "!!!!!!!!!!!!!!!!!"
fi

vol(){
    exec amixer -c 0 -- sset Master $1%
}

gotbot(){
    ssh root@104.251.214.76 -p 2212
}

devbot(){
    ssh root@104.237.13.51 -p 2212
}

getpdf(){
    wget -A pdf,dvi -m -p -np $1
}

play() {
    mpv --audio-display=no *.mp3
}

ytb () {
    youtube-dl -i -f best $1
}

sshz () {
    ssh zlin15@math.jhu.edu
}

nox() {
    killall i3
}

texcount() {
    ~/bashscript/TeXcount_3_0_0_24/texcount.pl $1
}


conkyset() {
    if [ "$1" = "normal" ]; then
        cp -T ~/bashscript/conky-normal ~/bashscript/conkyrc
    else
        cp -T ~/bashscript/conky-work ~/bashscript/conkyrc
    fi
}

#export LD_LIBRARY_PATH=/home/lz/works/s 
htopc() {
    htop -s Command
}

zat() {
    if [ "$1" = "-h" ]; then
        printf "\e[1musgae\e[0m:\n"
        printf "    zat -f full-filename\n"
        printf "    zat -h\n"
        printf "    zat filename-without-extension\n"
        printf "\e[1mexample\e[0m:\n"
        printf "    \e[2m[user@mach ~]$\e[0m ls\n"
        printf "    a.pdf b.png\n"
        printf "    \e[2m[user@mach ~]$\e[0m zat a        \e[7m# open a.pdf\e[0m\n"
        printf "    \e[2m[user@mach ~]$\e[0m zat -f a.pdf \e[7m# open a.pdf\e[0m\n"
        printf "    \e[2m[user@mach ~]$\e[0m zat b        \e[7m# convert b.png to a.pdf and then open a.pdf\e[0m\n"
    elif [ "$1" = "-f" ]; then
        local fn=$(find /opt/lz/pdf/*$2*)
        nohup zathura "$fn" &>/dev/null &
    else
        local homeland=$(pwd)
        local fn=$1
        if [ "$1" = "--stack" ]; then
            fn=$2
            cd ~/math/bib/stack
        fi
        if ls | grep "^$fn.pdf$"; then
            nohup zathura "$fn.pdf" &>/dev/null &
        elif ls | grep "^$fn.djvu$"; then
            nohup zathura "$fn.djvu" &>/dev/null &
        elif ls | grep "^$fn.ps$"; then
            nohup zathura "$fn.ps" &>/dev/null &
        elif ls | grep "^$fn.*$"; then
            lowriter --convert-to pdf $(ls | grep "^$fn.*$")
            nohup zathura "$fn.pdf" &>/dev/null &
        fi
        cd $homeland
    fi
}

e() {
    p=$(which $@)
    echo "Path = $p"
    nohup $p  &>/dev/null & exit
}

b() {
    nohup $(which $@) &>/dev/null & 
}

roll() {
    if [ "$1" != "" ]; then
        local si=$(pacman -Si $1)
        if [ "$si" = "" ]; then
            pacman -Ss $1
        else
            sudo pacman -S --needed $1
        fi
    else
        sudo pacman -Syu
    fi
}

sync_clock(){
    sudo ntpd -qg
    sudo hwclock -w
}

mountgoodreader4() {
    ifuse --documents com.goodiware.goodreader4 $1
}

mountgoodreader5() {
    ifuse --documents com.goodiware.goodreader5 $1
}

ipadapp() {
    if [ "$1" = "-l" ]; then
        ideviceinstaller -l
    else
        local appid=$(ideviceinstaller -l | grep $1 | awk '{print $1}' | sed "s/,//")
        ifuse --documents $appid $2
    fi
}

die() {
    shutdown -h now
}

nap() {
    systemctl suspend
}


is_a_member() {
    for item in $(echo $2); do
        if [ $item = $1 ]; then
            echo $item
            return
        fi
    done
}

lss() {
    case $1 in
    -k)
        ls --block-size=K -s;;
    -m)
        ls --block-size=M -s;;
    -g)
        ls --block-size=G -s;;
    esac
}

lu() {
    case $1 in
    -l|--longman)
        sdcv -u "Longman Dictionary of Contemporary English" $2;;
    -w|--webster)
        sdcv -u "Merrian Webster 10th dictionary" $2;;
    -t|--thesaurus)
        sdcv -u  "English Thesaurus" $2;;
    -g|--gcide)
        sdcv -u  "dictd_www.dict.org_gcide" $2;;
    -e|--eng2fra)
        sdcv -u "English - French" $2;;
    -f|--fra2eng)
        sdcv -u "French - English" $2;;
    esac
}

vboxc() {
    VBoxClient --clipboard
    VBoxClient --draganddrop 
    VBoxClient --display
    VBoxClient --checkhostversion
    sudo modprobe vboxsf 
    sudo mount.vboxsf $1 mnt
}

bashrc() {
    vim ~/bashscript/binit.sh
    source ~/bashscript/binit.sh
}

pacl() {
    pacman -Ql $1 | grep /usr/$2
}

k() {
    echo "scale=5;$1" | bc
}

scxxc() {
    g++ -std=c++14 -c "$1.cpp"
    g++ -std=c++14 -o "$1" "$1.o"
}

wsize() {
    local vganame=$(xrandr | sed '1d' | sed '2,$d' | awk '{print $1}')
    echo "VGA_Name = $vganame"
    local newmodecmd=$(cvt $1 $2 | sed "1d" | awk '{print "xrandr --newmode "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13}')
    local modename=$(eval echo $(echo $newmodecmd | awk '{print $3}'))
    echo "Mode = $(eval echo $modename)"
    echo "..........Check existing mode.........."
    if xrandr | grep $modename; then
        echo "..............Mode exists.............."
    else
        eval $newmodecmd
        xrandr --addmode $vganame $modename
    fi
    xrandr --output $vganame --mode $modename
}

newscript() {
    if [ "$1" = "-h" ] ; then
        echo "usage:"
        echo "    newscript filename script-type"
        echo "example:"
        echo "    newscript a sh"
        echo "    newscript a.py python"
        echo "    newscript a.sh bash"
    else
        local program=$2
        if [ "$2" = "" ] ; then
            program="python"
        fi
        sudo echo "#! /usr/bin/$program" > "$1"
        sudo chmod 755 "$1"
        sudo vim "$1"
    fi
}

newcpp() {
    read -p "new cpp file \"$1\"(Y/n)" b
    if [ $b != Y ]; then
        return
    fi
    echo "#include <iostream>" > "$1"
    echo "#include <string>" >> "$1"
    echo "#include <vector>" >> "$1"
    echo "" >> "$1"
    echo "using namespace std;" >> "$1"
    echo "" >> "$1"
    echo "int main()" >> "$1"
    echo "{" >> "$1"
    echo "    return 0;" >> "$1"
    echo "}" >> "$1"
    vim "$1"
}

work() {
    conkyset work
    python -c "
import time
import sys
import tty, termios
def getch():
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(sys.stdin)
    tty.setraw(fd)
    ch = sys.stdin.read(1)
    termios.tcsetattr(sys.stdin, termios.TCSADRAIN, old_settings)
    return ch
duration = 0
working = False
start_of_world = time.time()
while True:
    c = getch()
    if ord(c) == 3:
        break
    if ord(c) != 13:
        continue
    if not working:
        start_moment = time.time()
        print(\"Start Moment = \", start_moment-start_of_world)
    else:
        stop_moment = time.time()
        duration += stop_moment-start_moment
        print(\"Stop Moment = \", stop_moment-start_of_world)
        print(\"Duration = \", stop_moment-start_moment)
        print(\"Accumulated Duration = \", duration)
        print(\"Percentage = \", duration/(60*60*8))
    if duration > 60*60*8:
        break
    working = not working
"
    conkyset normal
}

battle() {
    python -c "import sys
a = int(sys.argv[1])
b = int(sys.argv[2])
s = 0.0
for i in [1,2,3,4,5,6]:
    for j in [1,2,3,4,5,6]:
        if a * i > b * j:
            s = s + 1

print(s/36)
" $1 $2
}

backlight() {
    case $1 in
       -d|--display)
           if [ "$2" != "0" ]; then
               echo "$2" > /sys/class/backlight/intel_backlight/brightness
           fi;;
       -k|--keyboard)
           echo "$[(($2 * 255) / 100) % 256]" > /sys/class/leds/smc\:\:kbd_backlight/brightness;;
    esac
}

pacs() {
# ifuse for apple device
    local c_sys="pacman procps-ng sudo systemd-sysvcompat which yaourt \
                 networkmanager licenses man-db man-pages linux-firmware \
                 logrotate mdadm xf86-input-mtrack xorg-xrandr \
                 xorg-server xorg-xinit xorg-xrdb xorg-server-devel \
                 xorg-xsetroot xorg-fonts-misc gnome-icon-theme\
                 xf86-video-vmware virtualbox-guest-utils\
                 make autoconf pkgconf patch fakeroot"
    local e_utl="xterm bc ntp sed screenfetch wget zip unzip \
                 alsa-utils htop iotop openssh sshpass rsync"
    local e_app="chromium sxiv gimp youtube-dl fcitx-googlepinyin \
                 conky i3-wm i3status i3lock i3blocks spacefm \
                 imagemagick wine sdcv ctags vi gvim mpv xsel scrot\
                 zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb \
                 python-pymupdf"
    local e_dev="clang sqlitebrowser"
    local e_fnt="font-mathematica gnu-free-fonts ttf-droid \
                 ttf-font-awesome ttf-monaco ttf-inconsolata wqy-microhei"
    local e_ser="npm redis python-flask python-redis python-pip"
    local keeps="$c_sys $e_utl $e_tex $e_app $e_dev $e_fnt $e_ser"
    local list=$(pacman -Qtt | awk '{print $1}')
    for name in $list; do
        if [ "$(eval "is_a_member $name \"$keeps\"")" != "" ]; then
            true
        else
            echo $name
        fi
    done
}

echo_vimrc() {
    echo $'
set ruler
set nu
syntax on
set cursorline
set hlsearch
set nocompatible
set backspace=indent,eol,start

command! Reloadrc :source ~/bashscript/vinit.vim
noremap <C-R> :Reloadrc<C-R>
source ~/bashscript/vinit.vim
' > ~/.vimrc
}


echo_xinitrc() {
    echo $'
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
    vganame=$(xrandr | sed \'1d\' | sed \'2,$d\' | awk \'{print $1}\')
    newmodecmd=$(cvt 1000 730 | sed "1d" | awk \'{print "xrandr --newmode "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13}\')
#    newmodecmd=$(cvt 1280 730 | sed "1d" | awk \'{print "xrandr --newmode "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13}\')
    modename=$(eval echo $(echo $newmodecmd | awk \'{print $3}\'))
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

autocutsel -fork &
autocutsel -selection PRIMARY -fork &
fcitx &
#xbindkeys
#xfce4-notifyd &
#nm-applet &
#xfce4-panel --disable-wm-check &
#xter -geometry 80x66+0+0 -fg grey -bg black -name login &
' > .xinitrc
}

gox() {
    echo_xinitrc
    echo_vimrc
    local cmd
    case $1 in
    --i3)
        cmd="exec i3";;
    --pl)
        cmd="exec startkde";;
    --ob)
        cmd="exec openbox";;
    --xf)
        cmd="xfwm4 & exec xfce4-panel";;
    --gn)
        cmd="exec gnome-session";;
    esac
    echo "CMD = $cmd"
    echo $cmd >> ~/.xinitrc
    startx
}

vimmt() {
    sudo vim /usr/share/vim/vimfiles/ftp*/la*/temp*/mt.tex
}

fw(){
    wsize 1920 1080
}
