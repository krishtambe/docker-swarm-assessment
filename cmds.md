# 🧪 DevOps Swarm – Complete Testing & Validation Runbook

This document contains all commands required to validate the Docker Swarm platform as per the DevOps assessment (Parts 1–8).

## PART 1 — Swarm & Stack Validation
docker info | grep Swarm
docker node ls

docker stack ls
docker service ls
docker stack ps voting

## PART 2 — Networking & Ingress
docker network inspect public_net | grep Encrypted
docker network inspect frontend_net | grep Encrypted
docker network inspect backend_net | grep Encrypted
docker network inspect monitoring_net | grep Encrypted

## PART 3 — Portainer
docker service ls | grep portainer

## PART 4 — Monitoring
docker service ls | grep prometheus
docker service ls | grep grafana

## PART 5 — Operations
docker service update --image ghcr.io/org/backend:v2 voting_backend

## PART 6 — Migration
kompose convert
helm install voting migration/helm

## PART 7 — CI/CD
git push origin main

## PART 8 — Security
docker inspect $(docker ps -q -f name=postgres) | grep POSTGRES_PASSWORD
