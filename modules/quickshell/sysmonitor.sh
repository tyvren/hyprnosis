#!/bin/bash

top_output=$(top -bn1)

cpu_usage=$(echo "$top_output" | grep "%Cpu(s)" | awk '{print $2}')
ram_usage=$(echo "$top_output" | grep "MiB Mem" | awk '{print ($7 / $3) * 100}')

echo "$cpu_usage $ram_usage"
