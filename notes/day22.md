# 9 Nov 2026 - Compose healthcheck + Kubernetes start

## Where things are (read first)
- Machine: practice EC2, folder `~/status-dashboard`
- Repo: Amruthjinesh/status-dashboard (branch main)
- Last pushed commit: `e13639a` (healthcheck + depends_on)
- Dashboard runs with `docker compose up -d`

## What I did today

### 1. Postgres healthcheck in docker-compose.yml
- Added a `healthcheck` to the postgres service, using `pg_isready`
- Added `depends_on` with `condition: service_healthy` to the app service
- Shape of it (fill in your own values):

```yaml
postgres:
  healthcheck:
    test: ["CMD-SHELL", "pg_isready -U <user>"]
    interval: <time>
    timeout: <time>
    retries: <number>
app:
  depends_on:
    postgres:
      condition: service_healthy
```

### 2. Why it matters
- Plain `depends_on` only starts Postgres first
- It does NOT wait until Postgres is ready
- `service_healthy` makes the app wait until the healthcheck passes

### 3. Test
- Ran `docker compose down`, then `docker compose up -d`
- Postgres showed **Healthy** before the app showed **Started**
- Committed locally as `e13639a`

### 4. Things that went wrong
- A vim edit went to the wrong place in docker-compose.yml
- Fix: restored from `docker-compose.yml.bak`, then wrote the whole file again with a `cat` heredoc
- A stray `.docker-compose.yml.swp` file is left in `~/status-dashboard`
  - It must NOT be committed
  - Still to remove it

### 5. Push to GitHub
- The 1 Nov token had expired
- Made a new 7-day classic token (repo scope), name `status-dashboard-push`, expires about 16 Nov
- Pushed `572d078..e13639a` from `~/status-dashboard` on the practice EC2
- Git asked for username and password; the token goes in as the password
- No credential helper on this EC2, so no token is saved

## Kubernetes (first class)

### What is Kubernetes?
- K8s = open-source container orchestration platform
- Automates deploying, scaling and managing containers across many machines
- Goal: less manual deployment work, better availability

### Core concepts
| Concept | Meaning | Simple example |
|---|---|---|
| Cluster | Whole K8s environment: Control Plane + Worker Nodes | A group of EC2 machines working together |
| Node | A server or VM that runs workloads | One EC2 as a Worker Node |
| Pod | Smallest deployable unit; 1 or more containers sharing network IP and storage | A Pod running my app container |
| Container | The packaged app process inside a Pod | Built from a Docker image |

Remember: Cluster = Control Plane + Worker Nodes. Worker Nodes run Pods. Pods hold containers. A Node is a machine, not a K8s service.

### Six main features
1. **Auto-Scaling**: more or fewer replicas based on CPU, memory or custom metrics
2. **Self-Healing**: restarts failed containers, reschedules Pods, can replace unhealthy Nodes (needs free capacity on healthy Nodes)
3. **Rollouts and Rollbacks**: rollout = move to a new version step by step; rollback = go back to the old version if the update fails or health checks fail
4. **Service Discovery and Load Balancing**: discovery = a stable way to find a service (internal IP or DNS); load balancing = spread traffic over healthy Pods
5. **Storage Orchestration**: connects storage to Pods (local, network, cloud like AWS EBS)
6. **Secret and Config Management**: passwords, tokens and settings stay out of the image

### Cluster architecture
Control Plane = directs the cluster, keeps desired state, schedules Pods, watches node health.
Worker Nodes = run the Pods and containers.

**Control Plane parts**
- **kube-apiserver**: the front door (API gateway). A `kubectl` request goes here first
- **etcd**: key-value database that stores cluster config and state
- **kube-scheduler**: picks which Worker Node a new Pod goes to
- **kube-controller-manager**: runs background loops that compare actual state with desired state and fix the difference (Node Controller, ReplicaSet Controller)

**Worker Node parts**
- **kubelet**: agent on each node; makes sure the containers in a Pod spec are running and healthy
- **kube-proxy**: keeps node network rules (iptables or IPVS) for traffic and load balancing; does NOT create Pods
- **Container Runtime**: the software that really runs containers (containerd, CRI-O)

### Easy to mix up
- **scheduler vs kubelet**: scheduler chooses the node; kubelet on that node runs the Pod's containers
- **apiserver vs controller-manager**: apiserver = gateway for requests; controller-manager = background reconcile loops
- **kube-proxy vs container runtime**: kube-proxy = network rules; runtime = runs containers
- **rollout vs rollback**: new version vs back to the old version
- **discovery vs load balancing**: finding the service vs spreading requests

### Examples discussed
- Worker Node goes unhealthy: Pods can be rescheduled to healthy Nodes, if there is capacity
- More traffic: Auto-Scaling adds Pod replicas
- Update fails health checks: Rollback restores the last working version
- A Service gives a stable way to reach Pods; kube-proxy keeps the rules that route traffic
- A Pod can use persistent cloud storage like an AWS EBS volume
- Passwords and tokens go in Secrets, not in the image

### Quiz
- "Kubernetes - Complete Notes Quiz", 10 questions: 10/10 (my own report; the answers were not saved)

### Next
- Tomorrow (10 Nov): small hands-on Kubernetes lab using Docker and AWS EC2

## Still to do
- Remove the stray `.docker-compose.yml.swp` file
- README: add "how to run with compose" and a healthcheck note
- Check where the old no-expiry "devops project" token is used, then delete it
- New token needed again after about 16 Nov
