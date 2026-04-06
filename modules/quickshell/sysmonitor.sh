#!/bin/bash

prev=$(grep 'cpu ' /proc/stat)
sleep 1
curr=$(grep 'cpu ' /proc/stat)

prev_idle=$(echo "$prev" | awk '{print $5}')
prev_total=$(echo "$prev" | awk '{for(i=2;i<=NF;i++)s+=$i;print s}')
curr_idle=$(echo "$curr" | awk '{print $5}')
curr_total=$(echo "$curr" | awk '{for(i=2;i<=NF;i++)s+=$i;print s}')

idle_delta=$((curr_idle - prev_idle))
total_delta=$((curr_total - prev_total))

[ $total_delta -gt 0 ] && cpu_usage=$((100 * (total_delta - idle_delta) / total_delta)) || cpu_usage=0

ram_usage=$(awk '/MemAvailable/{a=$2} /MemTotal/{t=$2} END{print (t-a)*100/t}' /proc/meminfo)

echo "$cpu_usage $ram_usage"
