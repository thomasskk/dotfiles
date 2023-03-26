#!/bin/bash
readonly VIDEOSHOTDIR="$HOME/.cache/videoshot"

if [[ ! -e $VIDEOSHOTDIR ]]; then
	mkdir -p "$VIDEOSHOTDIR"
fi

readonly PIDPATH="$VIDEOSHOTDIR/videoshot.pid"
readonly RESOURCEPATH="$VIDEOSHOTDIR/videoshot.txt"

if [[ ! -f "$PIDPATH" ]]; then
	readonly TIME="$(date +%Y-%m-%d-%H-%M-%S)"
	readonly VIDPATH="$VIDEOSHOTDIR/rec-$TIME.mp4"
	(
		wf-recorder -g "$(slurp)" -f "$VIDPATH" &
		echo "$!" >"$PIDPATH"
		echo "$VIDPATH" >"$RESOURCEPATH"
		notify-send "Start recording" "$VIDPATH"
		readonly PID="$(cat $PIDPATH)"
		wait "$PID"
		readonly VIDPATH="$(cat $RESOURCEPATH)"
		if [ ! -f "$VIDPATH" ]; then
			notify-send "Recording aborted"
		else
			wl-copy "file://${VIDPATH}"
			notify-send "Video uploaded" "$VIDPATH"
		fi
		rm "$PIDPATH"
		rm "$RESOURCEPATH"
	) &
else
	readonly PID="$(cat $PIDPATH)"
	kill -SIGINT "$PID"
fi
