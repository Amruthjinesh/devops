# Day 23 - Terraform project: status dashboard on AWS (10 Nov 2026)

## Goal
One terraform apply builds a server on AWS that runs the status dashboard (Python app + Postgres). No manual setup after apply.

## Project files (folder ~/terraform-project in Ubuntu WSL)
- variables.tf: region, instance_type, key_name, my_ip, db_password
- main.tf: aws provider, Ubuntu 24.04 image lookup, security group, EC2 with user_data
- outputs.tf: public_ip, dashboard_url, ssh_command
- .gitignore: .terraform/, *.tfstate, *.tfvars, *.pem, *.csv

## Steps
1. aws sts get-caller-identity showed terraform-user
2. made the folder and variables.tf
3. main.tf: provider, data aws_ami, security group (22 and 8000 from my IP only)
4. terraform init, validate, plan, apply: server built
5. copied jenkins.pem into ~/.ssh in WSL, chmod 400, logged in with ssh
6. Docker was already installed by user_data
7. by hand: installed docker-compose-v2, cloned the dashboard repo, made the env file, docker compose up: dashboard UP
8. moved those manual steps into user_data
9. db_password is a sensitive variable with no default
10. terraform apply -replace="aws_instance.server": new server, dashboard came UP by itself
11. terraform destroy: server and firewall removed

## What I learned
- validate checks the files only. plan previews. apply builds. destroy removes.
- aws sts get-caller-identity = who am I (which IAM user the saved key belongs to)
- IAM user = who I am to AWS. My IP = where I connect from. Two different things.
- /32 means exactly one IP address
- ingress = traffic in, egress = traffic out
- user_data runs only once, on first boot. To test a change, build a new server with -replace.
- the new server gets a new public IP
- >> adds to a file, > replaces the whole file
- the key must be copied into ~/.ssh in WSL and set to chmod 400
- terraform.tfstate holds the password, so it never goes to git. Real teams use Secrets Manager and remote state.

## Mistakes
- ran a laptop command on the server: always check the prompt first
- tail -n needs a number
- destroy still asks for every variable

## GitHub tokens
- deleted the old "devops project" token (never used)
- git push over HTTPS from an EC2 or WSL needs a token. Cloning a public repo needs none.
- one token expires 16 Nov 2026, the WSL token expires 10 Jan 2027
