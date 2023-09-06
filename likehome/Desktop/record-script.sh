#!/bin/bash
cp /home/martin/.dotfiles/likehome/.xinitrc-snimanje /home/martin/.dotfiles/likehome/.xinitrc
cp /home/martin/Desktop/put-this-int.etc.X11-aku\ sakash\ da\ snimash/xorg.conf /etc/X11/
mv /etc/X11/xorg.conf.d /etc/X11/.xorg.conf.d
killall X
