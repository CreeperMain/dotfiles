#!/bin/bash

DATE=`date "+%H:%M-%Y/%m/%d"`
#dont forget to do a --dry-run
rsync -axHAWXS --del --info=progress2 --exclude="steamapps" --exclude=".cache" / /mnt/backup/$DATE
