# Day 6 - docker-app on the deploy agent (11 Oct 2026)



## Goal

Run the docker-app pipeline on the EC2 deploy agent instead of my laptop.



## Problem

- The old Jenkinsfile uses Windows commands (bat, %VAR%).

- The agent is Ubuntu, so it can't run them.



## What I did

- Checked git, curl and docker on the agent (all worked, no sudo)

- Cloned docker-app, made branch agent-node

- Wrote a Linux Jenkinsfile (sh, $VAR, `|| true`)

- Used agent { label 'deployagent' }

- Made the "Save Previous Image" stage safe when no container exists

- Pushed the branch (commit 5f84849)

- Created job docker-app-agent on the controller (jenkinservice)

- Branch Specifier set to */agent-node



## Problem: node offline

- The deploy node showed offline.

- Cause: the EC2 public IP changed after restart.

- Fix: set Host to the private IP 172.31.35.213.

- Private IP stays the same after restart. Both EC2s are in one VPC.



## Result

- Log showed "Running on deploy"

- Build #2 SUCCESS, all stages passed incl. Health Check

- Build #3 SUCCESS after the Host change

- build-3 replaced build-2 on the agent, port 8000



## What I learned

- The agent only runs the build. Jenkins UI is on the controller.

- Jenkinsfile commands must match the agent's OS.

- Use private IPs between EC2s in the same VPC.



## Not tested yet

- Rollback on Linux (build-2 had "Previous image: none")

- Node after a full stop and start of both EC2s

