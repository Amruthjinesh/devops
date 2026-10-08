\# Day 4 - Jenkins Nodes



\## Concepts

\- Controller: the Jenkins server. Schedules jobs, stores config.

\- Node/agent: a machine that runs builds.

\- Built-in node: the controller runs builds itself.



\## Two methods

\- Controller method: builds run on the controller. Simple but risky.

\- SSH method: controller logs into another machine over SSH and starts an agent there.



\## Why not build on the controller

\- A heavy or broken build can crash Jenkins.

\- Builds can read controller secrets.



\## SSH agent needs

\- Java on the agent machine

\- SSH key credential in Jenkins

\- Port 22 open to the controller

\- Remote root directory

\- A label, e.g. ec2



\## Hands-on

(add after setting up the EC2 node)

