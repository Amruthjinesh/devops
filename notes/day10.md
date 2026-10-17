# Day 10 - 17 Oct 2026



## Git: diverged branches

- Practised in a throwaway folder with a fake remote and two clones (laptop, ec2).

- Both sides added a commit. ec2 pushed first.

- Laptop push was rejected (fetch first). Cause: diverged.

- Fix: git pull --no-rebase --no-edit origin master, then git push.

- Diverged = merge commit (two parents).

- Only behind = fast-forward, no merge commit.

- git log --oneline --graph shows the split and the join.



## Docker

- Image = recipe. Container = running copy.

- hello-world prints and exits. Status: Exited (0).

- nginx stays running because a server waits for requests.

- Port 8080 was taken, so I used -p 8081:80.

- docker ps = running only. docker ps -a = all.

- docker stop stops a container. It does not delete it.

- docker rm deletes a container.

- docker rmi deletes an image.

- An image can't be removed while any container uses it, even a stopped one.

- Exit code 0 = finished with no errors.



## Fixes

- docker not found in WSL: turn on WSL integration for Ubuntu in Docker Desktop.

- permission denied on docker.sock: sudo usermod -aG docker $USER

- Then run wsl --shutdown in Windows PowerShell, not inside Ubuntu.

- Reopen Ubuntu and start Docker Desktop.

- Find a file in Windows: where.exe /r . monitor.sh

- Find a file in Linux: find . -name monitor.sh

- cd takes folders, not files.

