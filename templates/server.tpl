#!/bin/bash

docker run -d \
  --restart=always \
  -e DRONE_OPEN=true \
  -e DRONE_HOST="${drone_host}" \
  -e DRONE_GITHUB=true \
  -e DRONE_GITHUB_CLIENT="${drone_github_client}" \
  -e DRONE_GITHUB_SECRET="${drone_github_secret}" \
  -p 80:8000 \
  -p 9000:9000 \
  -v /var/lib/drone:/var/lib/drone \
  drone/drone:0.8

docker run -d \
  --restart=always \
  -e DRONE_SERVER="${drone_agent_host}" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /root/.docker:/root/.docker \
  drone/agent:0.8