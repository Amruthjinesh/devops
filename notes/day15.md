\# Day 15 - Docker Hub and Jenkins push



\## What Docker Hub is

An online store for Docker images. My laptop and EC2 can both pull the same image from it.



\## How Jenkins logs in (dockerhub-creds)

\- Pushing needs a login. My access token is the password.

\- I saved the token once in Jenkins as `dockerhub-creds`.

\- The Jenkinsfile only uses the name, never the token.

\- The repo is public, so a token in the Jenkinsfile would be visible to everyone.

\- Jenkins hides the token in the logs (shows \*\*\*\*).



\## Why push comes after Health Check

Push is the last stage. If the app is broken, the build fails first. So Docker Hub only gets images that worked.



\## What "Mounted from" means

\- Images are made of layers.

\- The python:3.14 layers already exist on Docker Hub.

\- Docker does not upload them again. It says "Mounted from library/python".

\- Only my new layers say "Pushed".



\## The pipeline flow (GitHub to Docker Hub)

1\. I commit to GitHub.

2\. Jenkins checks GitHub every 2 minutes (Poll SCM) and sees the commit.

3\. Jenkins sends the job to the deploy agent EC2.

4\. The agent runs the stages with Docker: test, build, run, health check, push.

5\. The image lands on Docker Hub (build-8 pushed by Jenkins, build-50 by hand).

