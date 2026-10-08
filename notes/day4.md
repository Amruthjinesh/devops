# Day 4 - Jenkins Nodes

## Concepts
- Controller: the Jenkins server. Schedules jobs, stores config.
- Node/agent: a machine that runs builds.
- Built-in node: the controller runs builds itself.
- Label: a tag on a node. A job says "run on label X" and Jenkins picks a matching node.

## Two methods
- Controller method: builds run on the controller. Simple but risky.
- SSH method: controller logs into another machine over SSH and starts an agent there.

## Why not build on the controller
- A heavy or broken build can crash Jenkins.
- Builds can read controller secrets.

## SSH agent needs
- Java on the agent machine
- SSH key credential in Jenkins
- Port 22 open from the controller to the agent
- Remote root directory
- A label, e.g. deployagent

## Hands-on: node setup
- Two EC2 instances: one controller (Jenkins), one agent (Java).
- Node name: deploy, label: deployagent, connected over SSH.
- Test job node-test (Freestyle, restricted to label deployagent) ran `hostname`.
- Console output: "Building remotely on deploy (deployagent)".
- Mistake: typed `ubuntu` in the shell step, not `hostname`. Error: "ubuntu: not found".
- Lesson: the Execute shell step runs real commands, so every word is a command.

## Docker on the agent
- Installed docker.io on the agent (not the controller).
- First installed it on the controller by mistake. Checked the prompt hostname, then removed it.
- Added ubuntu to the docker group: `sudo usermod -aG docker ubuntu`.
- Running agent sessions keep old groups. Fix: Disconnect, then Launch agent.
- Error before the fix: "permission denied ... /var/run/docker.sock".
- Test: node-test running `docker ps` gave SUCCESS.

## Weather app deploy on the agent
- Job automation-pipeline (controller) deploys weather-app to /var/www/html on the controller.
- Made branch agent-node with `agent { label 'deployagent' }`.
- Copied the job as automation-agent, branch */agent-node, GitHub hook trigger off.
- Needed on the agent: nginx, and chown ubuntu on /var/www/html.
- Needed on the agent: port 80 open in the security group.
- Log: "Running on deploy" = SSH method. "Running on Jenkins" = controller method.
- Brave blocked the HTTP site until Shields were turned off.

## Webhook fix after IP change
- A stopped and started EC2 gets a new public IP.
- Old webhook URL pointed at the old IP, so GitHub got "failed to connect to host".
- Fix: deleted the webhook, made a new one with http://<controller-IP>:8080/github-webhook/. Response 200.
- Test: a push to master started automation-pipeline ("Started by GitHub push").
- Permanent fix: attach an Elastic IP to the controller.

## Risks to fix later
- SSH host keys are not verified on the node.
- Port 8080 is open to 0.0.0.0/0 so GitHub can reach Jenkins.
- Port 80 is limited to my IP, and the site is HTTP only.