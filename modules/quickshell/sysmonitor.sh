#!/bin/bash

cpu_usage=$(top -bn1 | grep "%Cpu(s)" | awk '{print $2}')
ram_usage=$(awk '/MemAvailable/{a=$2} /MemTotal/{t=$2} END{print (t-a)*100/t}' /proc/meminfo)

echo "$cpu_usage $ram_usage"
