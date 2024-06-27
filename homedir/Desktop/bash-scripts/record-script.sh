#!/bin/bash
doas -u martin cp /home/martin/.dotfiles/homedir/.xinitrc-snimanje /home/martin/.dotfiles/homedir/.xinitrc
nvidia-xconfig --prime
killall X
