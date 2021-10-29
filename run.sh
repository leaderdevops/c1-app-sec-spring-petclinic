#!/bin/bash
sudo rm logs/appsec.log logs/defence.log
DOCKER_BUILDKIT=1 docker build -t c1-app-sec-spring-petclinic .

docker run -p 8080:8080 --rm \
  --name c1-app-sec-spring-petclinic \
  -e TREND_AP_KEY=${APPSEC_KEY} \
  -e TREND_AP_SECRET=${APPSEC_SECRET} \
  -v $(pwd)/logs:/var/log/appsec:rw \
   c1-app-sec-spring-petclinic
