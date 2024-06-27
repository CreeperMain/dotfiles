#!/bin/bash
#run this as root cmd mkay?
doas -u martin git clone https://github.com/keylase/nvidia-patch
PATH=/opt/bin:$PATH
cd nvidia-patch
bash ./patch.sh
bash ./patch-fbc.sh
bash ./patch.sh -f
bash ./patch-fbc.sh -f
