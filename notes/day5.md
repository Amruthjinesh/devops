\# Day 5 - Jenkins agents (9 Oct 2026)



\## Done by me

\- Ran hostname build on inbound agent: passed

\- Ran hostname build on SSH deploy agent: passed

\- Each build showed its own agent's hostname



\## Not verified yet

\- Does inbound agent survive closing SSH?

\- Does it come back after reboot?

\- Does it reconnect after I kill it?



\## Next

\- Check TTY of agent.jar process

\- Decide: systemd service or not

\- Run failure test

