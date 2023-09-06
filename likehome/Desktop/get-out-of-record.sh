#!/bin/bash
cp /home/martin/.dotfiles/likehome/.xinitrc-normalno /home/martin/.dotfiles/likehome/.xinitrc
rm -rf /etc/X11/xorg.conf
mv /etc/X11/.xorg.conf.d /etc/X11/xorg.conf.d
killall X
