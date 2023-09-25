#!/bin/bash
doas -u martin cp /home/martin/.dotfiles/likehome/.xinitrc-normalno /home/martin/.dotfiles/likehome/.xinitrc
rm -rf /etc/X11/xorg.conf
killall X
