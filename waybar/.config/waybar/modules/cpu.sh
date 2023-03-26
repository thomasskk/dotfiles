used=$(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq | awk '{s+=$1; n++} END {printf "%0.1f", (s/n)/1000000}')
temperature=$(sensors | grep Core | awk '{s+=$3; n++} END {printf "%0.1f", s/n}')
percent=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')

echo '{"text": "'$used'GHz | '$temperature'°C <span color=\"darkgray\">| '$percent'%</span>"}'
