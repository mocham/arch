IP="192.168.1.16"
sshpass -p "x" rsync -r -t -c /opt/desktop/bashscript -e 'ssh -p 2232' lz@$IP:/home/lz/
sshpass -p "x" rsync -r -t -c /opt/desktop/Toys -e 'ssh -p 2232' lz@$IP:/home/lz/
sshpass -p "AQCnataF1" rsync -r -t -c /opt/desktop/vimfiles -e 'ssh -p 2232' root@$IP:/usr/share/vim/
sshpass -p "AQCnataF1" rsync -r -t -c /opt/desktop/bashscript/10-mtrack.conf -e 'ssh -p 2232' root@$IP:/etc/X11/xorg.conf.d/10-mtrack.conf
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/vimrc_ -e 'ssh -p 2232' lz@$IP:/home/lz/.vimrc
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/gvimrc_ -e 'ssh -p 2232' lz@$IP:/home/lz/.gvimrc
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/bashrc_ -e 'ssh -p 2232' lz@$IP:/home/lz/.bashrc
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/bash_profile -e 'ssh -p 2232' lz@$IP:/home/lz/.bash_profile
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/Xresources -e 'ssh -p 2232' lz@$IP:/home/lz/.Xresources
sshpass -p 'x' ssh lz@$IP -p 2232 mkdir -p /home/lz/.config/i3
sshpass -p 'x' ssh lz@$IP -p 2232 mkdir -p /home/lz/.config/spacefm
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/i3config -e 'ssh -p 2232' lz@$IP:/home/lz/.config/i3/config
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/spacefm-session -e 'ssh -p 2232' lz@$IP:/home/lz/.config/spacefm/session
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/spacefm-session -e 'ssh -p 2232' lz@$IP:/home/lz/.config/spacefm/session-last
sshpass -p "x" rsync -t -c /opt/desktop/bashscript/spacefm-session -e 'ssh -p 2232' lz@$IP:/home/lz/.config/spacefm/session-prior
