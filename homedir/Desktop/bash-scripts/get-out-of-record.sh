#!/bin/bash
doas -u martin cp /home/martin/.dotfiles/homedir/.xinitrc-normalno /home/martin/.dotfiles/homedir/.xinitrc
rm -rf /etc/X11/xorg.conf
killall X
