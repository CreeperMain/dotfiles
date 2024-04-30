xrandr --output eDP --brightness 0.4 &
gentoo-pipewire-launcher &
nitrogen --random ~/Wallpapers --set-zoom-fill &
picom -b &
export QT_QPA_PLATFORMTHEME=gtk2 #make sure qtstyleplugins is installed
$HOME/.config/dwm-config/bar-files/bar.sh &
exec dbus-launch --exit-with-session dwm
exec dwm
