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
