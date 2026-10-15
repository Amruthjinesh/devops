# Day 8 - Agent restart test and webhook fix



## Restart test (deploy agent)

- Stopped and started both EC2s

- Private IP unchanged: 172.31.35.213

- deploy node came back online with no edits

- docker-app-agent: build-5 SUCCESS, health check OK



## IP lesson

- Private IP: stays the same, used for node Host

- Public IP: changes on restart, used for webhook



## Webhook fix

- weather-app webhook was stale

- Updated Payload URL to the new controller public IP

- Push to agent-node -> automation-agent started automatically



## Cleanup

- Deleted patch-1 and amruthjinesh-patch-1
- Kept master and agent-node
\- Kept master and agent-node

