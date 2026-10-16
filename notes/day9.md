# Day 9 - PATH and cron (16 Oct 2026)

## PATH
- PATH is a list of folders the shell searches for commands.
- Check it with: echo $PATH
- Variable names are case-sensitive.
- $PATH works. $path is empty.
- Folders are separated by a colon.
- The shell searches left to right.
- WSL adds Windows folders (/mnt/c/...) to the list.

## cron
- crontab -l lists scheduled jobs.
- crontab -e edits them.
- */5 * * * * means every 5th minute.
- Fields: minute, hour, day of month, month, day of week.
- > overwrites a file.
- >> appends to a file.
- 2>&1 sends errors to the same place as normal output.

## Cron test
- Added a test line: * * * * * echo $PATH > ~/cronpath.txt
- Cron's PATH had only Linux folders.
- /usr/local/bin was on it.
- No /mnt/c folders.
- Cron skips shell startup files.
- So Windows tools like git or docker are not found in cron.
- Always use full paths in cron lines.
- Removed the test line and the file afterwards.

## WSL lesson
- Cron in WSL only runs while WSL is running.
- monitor.log had a gap from Oct 12 to Oct 16.
- That proves cron stopped when WSL stopped.
- A server like EC2 stays up, so cron is reliable there.

## Mistakes I made
- Typed & instead of $ in echo $PATH.
- Typed lowercase $path.
- Thought cron's PATH was small because it starts early.
- Real reason: cron does not load shell startup files.