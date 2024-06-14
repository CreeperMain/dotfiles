#!/bin/bash
doas -u martin cp /home/martin/.dotfiles/likehome/.xinitrc-snimanje /home/martin/.dotfiles/likehome/.xinitrc
nvidia-xconfig --prime
killall X
