#!/bin/sh

mem=$(free -m | grep 'Mem' | awk '{OFMT = "%0.1f"; printf("%.1f:%.1f", $3/1024, ($3*100)/$2) }')
used=$(echo $mem | cut -d':' -f1)
total=$(echo $mem | cut -d':' -f2)

echo '{"text": "'$used'G <span color=\"darkgray\">| '$total'%</span>"}'
