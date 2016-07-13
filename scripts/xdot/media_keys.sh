#!/bin/sh
 
case $1 in
    "play")
        key="XF86AudioPlay"
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
        ;;
    "next")
        key="XF86AudioNext"
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
        ;;
    "prev")
        key="XF86AudioPrev"
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
        ;;
    *)
        echo "Usage: $0 play|next|prev"
        exit 1
         ;;
esac
# xdotool search --class Chrome key $key
xdotool search --name "Google Play Music" key $key
xdotool search --name YouTube key $key
# xdotool search --name spotify key $key

exit 0
