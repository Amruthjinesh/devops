\# Day 7 - Running monitor.sh from anywhere



\## Wrong shell

\- PowerShell can't run bash scripts

\- `wsl` opened docker-desktop, not real Linux

\- Installed Ubuntu: `wsl --install -d Ubuntu`

\- Default distro: `wsl -s Ubuntu`



\## PATH and CRLF

\- PATH = folders the shell searches for commands

\- `echo $PATH` (capitals matter)

\- Windows adds `\\r` to line ends

\- Check: `head -1 monitor.sh | cat -A`

\- Fix: `sed -i 's/\\r$//' monitor.sh`



\## Install on PATH

\- `chmod +x \~/monitor.sh`

\- `sudo mv \~/monitor.sh /usr/local/bin/monitor.sh`

\- Run by name: `monitor.sh`



\## Git in Ubuntu

\- Needs its own name, email and token

\- Branch: `git checkout -b monitor-ubuntu`

\- Push: `git push -u origin monitor-ubuntu`

\- chmod error on /mnt/c is harmless



\## Cron

\- `crontab -e`

\- `\*/5 \* \* \* \* (date; /usr/local/bin/monitor.sh) >> /home/amruth/logs/monitor.log 2>\&1`

\- `crontab -l` lists jobs

\- A `#` at the start disables a line

\- Cron only runs while Ubuntu is running

