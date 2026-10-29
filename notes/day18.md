# Day 18 - Docker networking and the dashboard on AWS

Date: 29 Oct 2026

## Part 1: Docker networking (class)

### Default bridge network

- A container joins the default bridge network if no network is chosen.
- Class diagram: nginx-container and mysql-container on the default bridge.
- The user opens `server_ip:8000`. That reaches nginx.
- nginx talks to mysql on port 3306 inside the network.
- On the diagram the containers talk by IP address (172.100.100.1 and 172.100.100.2).

```
docker run --name nginx-container -p 8000:80 nginx:latest
docker run --name mysql-container mysql:latest
```

- `-p 8000:80` means host port 8000 goes to container port 80.
- mysql listens on 3306 and is not published to the host.

### Network commands

```
docker network create app-net
docker network ls
docker network rm app-net
docker network connect app-net mysql-container
docker network disconnect app-net mysql-container
docker run -d --name nginx-container --network app-net -p 8000:80 nginx:latest
```

- `create` makes a custom network named app-net.
- `ls` lists all networks.
- `rm` removes a network.
- `connect` adds an existing container to a network.
- `disconnect` removes a container from a network.
- `--network app-net` on `docker run` starts the container inside that network.

### Class exercise

1. Create a network named sample-net.
2. Verify the created network.
3. Create nginx-container inside sample-net.
4. Create mysql-container inside sample-net.
5. Use inspect on both containers and verify the network and DNS names.
6. Disconnect nginx-container from sample-net.
7. Connect nginx-container back to sample-net.

What I ran for step 4 (my network was named sample-network):

```
docker run -d --name mysql-container --network sample-network -e MYSQL_ROOT_PASSWORD=<password> mysql:latest
```

- `-e` sets an environment variable. The mysql image needs the root password this way.
- Results of inspect, disconnect and connect: to fill in.

## Part 2: DevOps dashboard on AWS (project)

- The cards version of the dashboard (Docker, Jenkins, CI/CD, Cloud) was only inside the local image devops-python-app:latest.
- GitHub had the Version 40, 41 and 42 test files instead (rollback tests).
- Copied app.py out of the image with docker create and docker cp, then put it on main of docker-app using the GitHub pencil.
- Webhook delivery failed with ERR_NGROK_3200. ngrok was not running.
- Started ngrok. After a new commit, build 52 started with "Started by GitHub push". Build 51 was started by hand.
- Copied the same app.py to the agent-node branch. Did not merge, because the Jenkinsfiles differ (Windows vs Linux).
- Started the controller and deploy agent EC2s. Build 9 of docker-app-agent finished SUCCESS.
- The page did not open on the deploy agent at first. Port 8000 was missing from the inbound rules of its security group. After adding it, the dashboard loaded.
- The cards are still plain text. They do not check anything yet.
