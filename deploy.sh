#!/bin/bash
docker login
DOCKER_BUILDKIT=1 docker build -t c1-app-sec-spring-petclinic .
docker tag c1-app-sec-spring-petclinic ${DOCKER_USERNAME}/c1-app-sec-spring-petclinic:latest
docker push ${DOCKER_USERNAME}/c1-app-sec-spring-petclinic:latest

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
  name: c1-app-sec-spring-petclinic
  labels:
    app: c1-app-sec-spring-petclinic
spec:
  type: LoadBalancer
  ports:
  - port: 8080
    name: c1-app-sec-spring-petclinic
    targetPort: 8080
  selector:
    app: c1-app-sec-spring-petclinic
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: c1-app-sec-spring-petclinic
  name: c1-app-sec-spring-petclinic
spec:
  replicas: 1
  selector:
    matchLabels:
      app: c1-app-sec-spring-petclinic
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  template:
    metadata:
      labels:
        app: c1-app-sec-spring-petclinic
    spec:
      containers:
      - name: c1-app-sec-spring-petclinic
        image: ${DOCKER_USERNAME}/c1-app-sec-spring-petclinic:latest
        imagePullPolicy: Always
        env:
        - name: TREND_AP_KEY
          value: ${APPSEC_KEY}
        - name: TREND_AP_SECRET
          value: ${APPSEC_SECRET}
        ports:
        - containerPort: 8080
EOF
