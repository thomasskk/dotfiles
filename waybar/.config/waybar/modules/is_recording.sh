pid=$(pidof wf-recorder)
if [ "$pid" ]; then
	echo '{"text": "<span color=\"red\"></span>'$(ps -p "$pid" -o etime=)'"}'
else
	echo '{"text": ""}'
fi
