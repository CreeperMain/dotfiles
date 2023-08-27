xrandr --output eDP --brightness 0.6
gentoo-pipewire-launcher &
nitrogen --restore
picom -b &
$HOME/.config/dwm-config/bar-files/bar.sh &
exec dwm
