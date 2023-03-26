#!/bin/bash
readonly SCREENSHOTDIR="$HOME/.cache/screenshot"

if [[ ! -e "$SCREENSHOTDIR" ]]; then
	mkdir -p "$SCREENSHOTDIR"
fi
readonly TIME="$(date +%Y-%m-%d-%H-%M-%S)"
readonly IMGPATH="$SCREENSHOTDIR/img-$TIME.png"
slurp | grim -g - - | wl-copy && wl-paste >"$IMGPATH"
notify-send "Screenshot uploaded" "$IMGPATH"
