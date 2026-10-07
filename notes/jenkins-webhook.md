\# Jenkins GitHub webhook



Error: GitHub showed a red cross, "failed to connect to host".

Possible causes: wrong or old EC2 IP, or typo in the Payload URL. (Port 8080 was already open, so not that.)

Fix: deleted the webhook in GitHub and created a new one with http://<EC2-public-IP>:8080/github-webhook/

Check next time: compare EC2 public IP with the webhook Payload URL.

