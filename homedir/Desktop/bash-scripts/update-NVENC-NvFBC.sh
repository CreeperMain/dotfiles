#!/bin/bash
doas -u martin git clone https://github.com/keylase/nvidia-patch
cd nvidia-patch
bash ./patch.sh
bash ./patch-fbc.sh
bash ./patch.sh -f
bash ./patch-fbc.sh -f
