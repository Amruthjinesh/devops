
# Day 20: Terraform first run (2 Nov 2026)



## What Terraform is

A tool where I write a file that describes a server, and one command builds it in AWS. No clicking in the console.



## Setup (Ubuntu WSL)

- Added HashiCorp's apt source (key, then source list), then `sudo apt install terraform` gave v1.17.1.

- Installed the AWS CLI from Amazon's zip installer (`sudo ./aws/install`), then deleted the zip and folder.

- Forgot my Ubuntu password. Fixed it from PowerShell: `wsl -u root`, then `passwd amruth`.



## AWS login

- Made an IAM user `terraform-user` with AmazonEC2FullAccess only, no console access.

- Made an access key for the CLI and downloaded the .csv. It must never go into git.

- `aws configure` saved the key in `~/.aws/credentials` (region eu-west-2, output json).

- `aws sts get-caller-identity` showed terraform-user, so the login works.



## First project: ~/terraform-first

- `main.tf` has a provider block (AWS, eu-west-2), a data block that finds the newest Ubuntu 24.04 image, and a resource block for one t3.micro named terraform-first.

- `terraform init` downloads the AWS plugin.

- `terraform validate` checks the file.

- `terraform plan` shows what will change (1 to add), builds nothing.

- `terraform apply` builds it. It took 18 seconds and showed Running in the EC2 console.

- `terraform destroy` deletes it. It took 32 seconds.



## Learned

- Terraform only needs the key. The AWS CLI is optional, but it saves the key, checks the login and lets me look at servers.

- Terraform keeps track of what it built in terraform.tfstate. Do not edit or delete it by hand.

- Never use the root account for access keys. Use a separate IAM user with small rights.

- Always read the plan before apply.

- Checked all regions with a loop: nothing running, all my older servers are stopped.



## Keep out of git

- .terraform folder

- terraform.tfstate and its backup

- the access key .csv file





