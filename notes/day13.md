# Day 13 - Push an image to Docker Hub



Date: 25 Oct 2026



## Goal

Put the docker-app image on Docker Hub so it can be pulled from anywhere.



## Steps

1. Log in to hub.docker.com in the browser.

2. Make an access token: Account settings > Personal access tokens > Generate new token. Name: jenkins-token. Permission: Read & Write. Copy it. It shows only once.

3. Open Docker Desktop on the laptop and wait for "Engine running". Without it, Ubuntu WSL says "docker could not be found".

4. In Ubuntu WSL, log in with the token (not the account password):



&#x20;      docker login -u amruthjinesh007



5. Add the username to the image name:



&#x20;      docker tag devops-app:build-50 amruthjinesh007/devops-app:build-50



6. Push it:



&#x20;      docker push amruthjinesh007/devops-app:build-50



7. Check on Docker Hub: repository amruthjinesh007/devops-app > Tags tab shows build-50.



## Why docker tag is needed

Docker Hub needs to know whose space the image goes to. A name with no username is treated as library/, the space for official images like python and nginx. We cannot write there, so the push is refused. It is like a parcel with no name on it.



## Things I noticed

- docker tag does not copy the image. It adds a second name. Both names have the same ID (ec32ce735b85).

- "Mounted from library/python" in the push output means those layers were already on Docker Hub. Only the new layers were uploaded, so the push was fast.

- Use a token, not the password. Jenkins will use the same token later.



## Next

- Make Jenkins push the image by itself after each good build.

- Rewrite the docker-app README (last).

