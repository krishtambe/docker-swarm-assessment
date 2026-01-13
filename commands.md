## Deployment Commands

- Initialize Docker Swarm
```
docker swarm init
```


 - Join worker nodes:

```
docker swarm join --token <token> <manager-ip>:2377
```

 - Create encrypted overlay networks
```
docker network create -d overlay --opt encrypted public_net
docker network create -d overlay --opt encrypted frontend_net
docker network create -d overlay --opt encrypted backend_net
docker network create -d overlay --opt encrypted monitoring_net
```
- Create secrets
```
echo postgres | docker secret create db_user -
echo StrongPass123 | docker secret create db_password -
```

- Verify:

```
docker secret ls
```

 - Deploy stack

```
docker stack deploy -c docker-compose.yml voting
```

- Verify:

```
docker stack ls
docker service ls
```

- Functional Testing
  - Check service health
```
docker service ps voting_vote
docker service ps voting_worker
docker service ps voting_postgres
```

- Verify application

```
curl http://app.example.com
curl http://app.example.com/api/health
```

- Verify DNS-based service discovery

```
docker exec -it $(docker ps -q -f name=voting_vote) ping postgres
```

- Security & Network Testing
- Ensure frontend cannot reach DB

```
docker run -it --rm --network frontend_net alpine ping postgres
```

- (Expected: fails)

```
docker run -it --rm --network backend_net alpine ping postgres
```


- (Expected: works)
-  Monitoring Validation

```
docker service ls | grep prometheus
docker service ls | grep grafana
```

- Access Grafana:

```
http://<node-ip>:3000
```

- Rolling Update Test

```
docker service update \
  --image ghcr.io/org/backend:v2 \
  --update-parallelism 2 \
  --update-delay 10s \
  voting_backend
```

- Simulate Failure & Auto-Rollback

```
docker service update --image ghcr.io/org/backend:broken voting_backend
```


- Check rollback:

```
docker service ps voting_backend
```

- Manual Rollback

```
docker service rollback voting_backend
```

- Troubleshooting

```
docker service logs voting_backend
docker service ps voting_backend --no-trunc
docker inspect <task-id>
```

- Portainer Automation

- Deploy stack:

```
./scripts/portainer-stack.sh
```

- Backup & Restore Swarm

- Backup:

```
tar czf swarm-backup.tgz /var/lib/docker/swarm
```


- Restore:

```
systemctl stop docker
tar xzf swarm-backup.tgz -C /var/lib/docker
systemctl start docker
```
