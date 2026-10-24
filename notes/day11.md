# Day 11 - Dockerfile and containers (22 Oct 2026)



## What I did

Cloned docker-app, read the Dockerfile, built my own image and ran it on my laptop in Ubuntu WSL with Docker Desktop.



## The Dockerfile, line by line

* FROM python:3.14 : base image, a mini Linux with Python already installed
* WORKDIR /app : sets the folder inside the container, creates it if missing
* COPY app.py . : copies app.py from my machine into /app in the image
* EXPOSE 8000 : only documents the port, does not open it
* CMD \["python3", "app.py"] : start command, runs at docker run, not at docker build



## Build time vs run time

* docker build makes the image (FROM, WORKDIR, COPY)
* docker run starts a container and only then CMD runs



## Port map host:container

* docker run -d -p 9000:8000 mytest
* Left = port on my laptop, my free choice
* Right = port the app listens on inside the container, must be 8000
* app.py uses 0.0.0.0 so the container accepts outside connections



## The 41 / 42 test

* I changed Version 41 to 42 in app.py and the page still showed 41
* docker build made a new image with 42
* The running container was still made from the old image
* A running container does not follow image changes
* Only stop, rm, run made a new container, and then it showed 42
* Order: edit, build, stop, rm, run
* Same loop Jenkins runs on every push
* devops-app (build-49) still shows Version 40 because that image was built before my local edits
* To change it, push to GitHub and let Jenkins build a new image



## Cleanup

* Removed test containers and images by name
* Kept devops-app container, devops-app:build-48 and build-49, python:3.14
* Did not use docker system prune, it would also delete stopped containers I want to keep



## Mistakes

* Linux is case-sensitive: Dockerfile is not dockerfile
* docker build needs the dot at the end, it tells Docker where the Dockerfile is
* I typed the placeholder NAME literally, use the real container name
* Port already allocated: an old container was still using 9000
* Docker Desktop must be running for docker to work in WSL



## Commands used

* docker build -t mytest .
* docker run -d -p 9000:8000 mytest
* docker ps and docker ps -a
* docker stop NAME and docker rm NAME
* docker images and docker rmi NAME

