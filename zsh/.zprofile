if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	export MOZ_ENABLE_WAYLAND=1
	# GTK
	export CLUTTER_BACKEND=wayland
	# QT
	export QT_QPA_PLATFORM=wayland-egl
	export QT_WAYLAND_FORCE_DPI=physical
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
	# SDL
	export SDL_VIDEODRIVER=wayland
	# Java
	export _JAVA_AWT_WM_NONREPARENTING=1

	export WLR_NO_HARDWARE_CURSORS=1

	exec sway
fi
