# Linux System Monitor

A Bash script that checks disk usage, memory usage, and basic system stats on a Linux server, with alert thresholds for disk and memory (80%).

## Usage
    chmod +x monitor.sh
    ./monitor.sh

## What it checks
- Disk usage (warns at 80%)
- Memory usage (warns at 80%)
- Basic system info (uptime, hostname, kernel)
