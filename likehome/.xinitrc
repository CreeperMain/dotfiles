xrandr --output eDP --brightness 0.4 &
gentoo-pipewire-launcher &
nitrogen --random ~/Wallpapers/good wallpapers/ --set-zoom-fill &
picom -b &
export QT_QPA_PLATFORMTHEME=gtk2 #make sure qtstyleplugins is installed
exec slstatus &
exec dbus-launch --exit-with-session dwm
exec dwm
