## Day 2 - Jenkins + Docker pipeline

- Jenkins job `docker-app-pipeline` builds and deploys my docker-app repo
- Stages: Clone, Build Docker Image, Stop Old Container, Run New Container, Health Check
- `docker run -d` returns right away, so a green build did not prove the app worked
- Added a Health Check stage: `curl -f` fails the build if the app doesn't answer
- Tested it by pointing the check at the wrong port (9999): build went red. Fixed it back: green
