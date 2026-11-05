# Docker Compose â€“ Day 17

## Topic: Docker Compose â€“ Lifecycle, Volumes & Dependencies



### 1. Docker Compose

- Docker Compose manages multiple containers using a `docker-compose.yml` file.

- It helps run multiple services together.

- Example: Nginx + PostgreSQL + Python application.



### 2. Important Commands



```bash

# Start services in detached mode

docker compose up -d



# Build images and start containers

docker compose up -d --build



# Check running containers

docker compose ps



# View logs

docker compose logs



# Stop and remove containers and networks

docker compose down



# Remove containers, networks and volumes

docker compose down -v



# Remove images while bringing down

docker compose down --rmi all

```



### 3. What Does docker compose down Delete?



| Resource | docker compose down |

|---|---|

| Containers | Deleted |

| Default network | Deleted |

| Images | Kept |

| Volumes | Kept |

| HTML folder on host | Kept |



**Remember:**

- `docker compose down` â†’ Removes containers and networks.

- `docker compose down -v` â†’ Also removes Compose-managed volumes.

- `docker compose down --rmi all` â†’ Also removes service images.



### 4. depends_on



- `depends_on` controls the startup order of services.

- It starts the dependency before the dependent service.

- However, it does not automatically wait until the database is ready.



Example:



```yaml

services:

&#x20; app:

&#x20;   depends_on:

&#x20;     db:

&#x20;       condition: service_healthy



&#x20; db:

&#x20;   image: postgres:16

&#x20;   healthcheck:

&#x20;     test: ["CMD-SHELL", "pg_isready -U postgres"]

&#x20;     interval: 5s

&#x20;     timeout: 3s

&#x20;     retries: 5

```



**Important:**

- `depends_on` â†’ Controls startup order.

- `healthcheck` â†’ Checks whether the service is healthy.

- `service_healthy` â†’ Waits for the dependency to become healthy.



### 5. Restart Policy



```yaml

restart: unless-stopped

```



- Automatically restarts a container when it exits.

- Keeps restarting unless manually stopped.

- Useful when an application exits unexpectedly.

- Does not replace proper application retry logic.



### 6. Port Mapping



Example:



```yaml

ports:

&#x20; - "8081:80"

```



- `8081` â†’ EC2 host port.

- `80` â†’ Container port.



To access the application through a browser:

&#x20;

```text

http://EC2-PUBLIC-IP:8081

```



AWS Security Group must allow inbound TCP port `8081`.



For practice, restrict the source to **My IP** rather than opening it to everyone.



### 7. Important Learning Points



- Images and containers are different.

- Removing a container does not automatically remove its image.

- Volumes preserve application data beyond container removal.

- Bind-mounted host folders remain on the host.

- `depends_on` alone does not guarantee database readiness.

- Security Groups control external network access.



### 8. Practice Commands



```bash

cd ~/nginx-test



docker compose up -d



docker compose ps



docker compose logs



docker compose down



docker compose up -d --build

```



### Today's Revision



1. What does `docker compose down` remove?

2. What is the difference between `down` and `down -v`?

3. Does `depends_on` wait for PostgreSQL to become ready?

4. Why do we use healthchecks?

5. What does `8081:80` mean?



**Today's takeaway:** Understand what Docker Compose creates, what it removes, and how services communicate and start in the correct order.


