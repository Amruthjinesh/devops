# Day 9 - PATH and cron (16 Oct 2026)



## PATH

- PATH is a list of folders the shell searches for commands.

- Check it with: echo $PATH

- Variables are case-sensitive: $PATH works, $path is empty.

- WSL adds Windows folders (/mnt/c/...) to the list.



## cron

- crontab -l lists scheduled jobs. crontab -e edits them.

- \*/5 \* \* \* \* means every 5th minute.

- Five fields: minute, hour, day of month, month, day of week.

- >> appends to a file. 2>\&1 sends errors to the same place.



## Lessons

- Cron uses a small PATH, so use full paths in cron lines.

- Cron in WSL only runs while WSL is running.

\- The log showed a gap from Oct 12 to Oct 16, which proves it.

