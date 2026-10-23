# Day 12 – Docker, Jenkins agent pipeline, Poll SCM

## Docker
- Dockerfile: `FROM nginx:latest`, `COPY index.html ...`, `EXPOSE 80`
- An image is a snapshot. `COPY` runs at build time, not run time.
- To see a file change: edit file → `docker build` → stop and remove old container → `docker run`
- `docker restart` does not change the page. The old image is reused.
- Edits made inside a running container are lost. Only the Dockerfile lasts.
- Port map `8082:80`. To see it in a browser, open the port in the security group (My IP only), then close it after.
- Cleanup: `docker stop`, `docker rm`

## Jenkins on EC2
- Controller: holds the job, starts the run, shows logs. No Docker needed.
- Deploy agent: runs the stages, has Docker (label `deployagent`)
- Job `docker-app-agent` reads the `Jenkinsfile` from the `agent-node` branch

## Pipeline stages
Test (`py_compile`) → Build image → Save previous image → Stop old container → Run new container → Health check → Rollback on failure

- Build 6 passed
- Rollback was tested earlier by breaking the health check on purpose

## Poll SCM
- Schedule `H/2 * * * *` means check GitHub about every 2 minutes
- Polling log said "No changes" when nothing new was pushed
- Edited `trigger-test.txt` on GitHub → build 7 started by itself ("Started by an SCM change")
- Build 7 reused every cached layer, because `app.py` did not change

## Webhook vs polling
- Webhook: GitHub tells Jenkins instantly. Needs a public address (ngrok for my laptop Jenkins).
- Polling: Jenkins asks GitHub. Needs nothing extra, up to 2 minutes slower.
- Polling only works while the controller is running.

## Habits
- Stop servers when done (stop, not terminate)
- Paste only the command, not the whole terminal. A stray `EOF` line ended up inside my `index.html` and I fixed it with `sed -i`.