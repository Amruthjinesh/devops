#!/bin/bash

echo "=============================="
echo "     LINUX SYSTEM MONITOR"
echo "=============================="

echo "User: $(whoami)"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "Memory Usage:"
free -h

echo ""
echo "System Information:"
uname -a
echo ""
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)"
echo ""
echo "Disk Alert Check:"

DISK=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$DISK" -ge 80 ]; then
    echo "WARNING: Disk usage is ${DISK}%"
else
    echo "OK: Disk usage is ${DISK}%"
fi
echo ""
echo "Memory Alert Check:"

MEM=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

if [ "$MEM" -ge 80 ]; then
    echo "WARNING: Memory usage is ${MEM}%"
else
    echo "OK: Memory usage is ${MEM}%"
fi
