# Day 19 - Docker: Python app + Postgres + status dashboard

> ## READ THIS FIRST: after stopping and starting the EC2s
>
> 1. Public IPs change. On the practice EC2, edit TARGETS in ~/status-app.env with the new Jenkins and deploy agent IPs. Then recreate the status-app container, because it only reads that file when it is created.
> 2. postgres does not start by itself. On the practice EC2, run: docker start postgres
> 3. devops-app may be stopped on the deploy agent. On the deploy agent, run: docker start devops-app
> 4. The dashboard address changes too. Copy the practice EC2 new public IP from the AWS console.
>
> Why start devops-app: the dashboard checks the deploy agent on port 8000. devops-app listens there. If it is stopped, the check says DOWN.
> Always Stop the EC2s. Never Terminate (terminate deletes the server).

## Goal
Run a Python app and a Postgres database in separate containers on my own Docker network, and show the results on a web page.

## Part 1 (31 Oct): Python app + Postgres
What I built (on the practice EC2):
- Custom network `my-net`
- Postgres 16 container named `postgres`, with a volume so data survives
- Python image `status-app`, built from my own Dockerfile
- The app checks if Jenkins is up or down every 30 seconds and saves each result in a Postgres table

Key commands:
- `docker network create my-net` - makes the network
- `docker run -d --name postgres --network my-net -v pgdata:/var/lib/postgresql/data postgres:16` - starts the database
- `docker build -t status-app .` - builds my image
- `docker run -d --restart unless-stopped --network my-net status-app` - runs the app in the background
- `docker logs status-app` - shows what the app printed
- `docker exec -it postgres psql -U dash -d status_db` - opens the database

## Part 2 (1 Nov): web page, settings, GitHub
- Added Flask: a web page on port 8000 with a card per server (UP or DOWN) and a table of the last 10 checks
- The checker runs in a side thread, Flask runs in the main thread
- Added the deploy agent as a second server to check
- Moved the password and server list into `~/status-app.env`, run with `--env-file`
- Pushed the code to GitHub: Amruthjinesh/status-dashboard, with a README and screenshot
- Kept the old .bak backup files out of GitHub because they hold the old password

## Steps to build this project (in order)

Phase 1: The base (practice EC2)
1. Make a project folder: ~/status-dashboard
2. Make a Docker network: my-net
3. Run a Postgres container on my-net with a database name, user and password
4. Check it is running with docker ps

Phase 2: The checker (Python)
5. Write a program that opens the Jenkins login URL with a 3 second timeout
6. Any reply is "up", no reply is "down"
7. Save each result to a Postgres table: name, status, time
8. Repeat every 30 seconds

Phase 3: Put the checker in Docker
9. List the tools in requirements.txt
10. Write the Dockerfile (Python base, copy files, install tools, run app.py)
11. Build the image: docker build -t status-app .
12. Run it on my-net in the background with --restart unless-stopped
13. Read the logs: docker logs status-app

Phase 4: The web page
14. Add flask to requirements.txt and import it in app.py
15. Make the main page: read the newest rows from Postgres and build the HTML
16. Show a card per server and a table of the last 10 checks
17. Run the checker in a side thread, Flask in the main thread
18. Run with -p 8000:8000 and open port 8000 in the security group for My IP only
19. Open http://PRACTICE-EC2-IP:8000 in the browser
   Page not opening? Check in order: container running, logs, security group

Phase 5: Make it better
20. Add the deploy agent to TARGETS
21. Move DB_PASSWORD and TARGETS into ~/status-app.env
22. Remove the old container and run a new one with --env-file ~/status-app.env
23. Style the page (CSS is inside app.py, so rebuild the image)

Phase 6: Share it
24. Add a .gitignore (env file and old .bak files stay out)
25. Make a GitHub repo and push the code
26. Write a README with a screenshot
27. Write the day notes

## How the app works
- `os.getenv("NAME", "default")` reads a setting. The env file gives Docker the settings when the container is created.
- `check(url)` opens the URL with a 3 second timeout. Any reply is UP, no reply is DOWN.
- `save()` adds one row to the table `checks`. `monitor()` loops forever: check, save, print, sleep 30 seconds.
- Flask: `@app.route("/")` runs `home()` when someone opens the page. It reads rows from Postgres and builds the HTML.
- The page refresh every 30 seconds comes from an HTML meta refresh tag, not from Flask.
- The table keeps every check forever. The page only shows the last 10.

## What I learned
- Containers on a custom network find each other by name. The app connects to host `postgres`, not an IP.
- `localhost` inside a container means the container itself, not the server.
- Postgres and the app go in separate containers, so I can rebuild the app without losing data.
- Every network check needs a timeout, or a dead server makes the app hang.
- `000` from curl means it could not connect. The server was off.
- Never put passwords in code that goes to GitHub.
- Change in app.py: edit, build the image, remove the old container, run a new one. Change in the env file: only remove and run again.
- `-p 9000:8000`: left is the EC2 port (open it in the security group), right is the container port.
- `curl localhost:PORT` on the EC2 proves the container works, but not the security group.
- A stopped EC2 gets a new public IP when started again. Containers that are not set to restart stay stopped.
- A stale "Last check" time on a card means the monitor thread is dead.

## Ideas to improve
1. Check the server itself on port 22, plus the app check
2. Wrap save() in try/except so a Postgres outage does not kill the loop
3. Show STALE when the last check is too old
4. Treat error pages (500) as DOWN, not UP
5. Delete old rows from the table
6. Use an Elastic IP so the address stops changing

## Next
- Add the server check (idea 1)
- Rename dashboard.png.png on GitHub
- Delete the 7 day GitHub token when done