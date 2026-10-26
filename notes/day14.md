# Day 14 - Dockerfile, image, container



- Dockerfile = recipe. Image = built result. Container = running copy of the image.

- Build: docker build -t name .   (the dot = Dockerfile in this folder)

- RUN happens once, at build time. Example: RUN pip install flask

- CMD happens every time a container starts. Example: CMD ["python", "app.py"]

- Test: RUN printed during docker build. CMD printed on each docker run.

- Edit Dockerfile, then docker run without rebuild = still the OLD behaviour.

- Fix: edit, rebuild image, run a new container.

- Quiz miss: RUN vs CMD (missed again, now tested myself).

