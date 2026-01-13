# Enterprise Docker Swarm DevOps Assessment

This repository implements a full production-grade Docker Swarm platform using the
dockersamples/example-voting-app microservices.

## Architecture

            ┌────────────────────────┐
            │        Internet         │
            └───────────┬────────────┘
                        │
                 ┌──────▼──────┐
                 │   Traefik   │
                 │ (public_net)│
                 └──────┬──────┘
                        │
        ┌───────────────▼───────────────┐
        │         Frontend Tier          │
        │  vote, result (frontend_net)   │
        └───────────────┬───────────────┘
                        │
        ┌───────────────▼───────────────┐
        │          Backend Tier          │
        │  worker, API (backend_net)     │
        └───────────────┬───────────────┘
                        │
        ┌───────────────▼───────────────┐
        │         Data Tier              │
        │  PostgreSQL + Redis            │
        │        (backend_net)           │
        └───────────────────────────────┘


Monitoring stack (Prometheus, Grafana, cAdvisor, Node Exporter) runs on monitoring_net.

All networks are encrypted overlay networks.

## Deployment

docker swarm init

docker network create -d overlay --opt encrypted public_net
docker network create -d overlay --opt encrypted frontend_net
docker network create -d overlay --opt encrypted backend_net
docker network create -d overlay --opt encrypted monitoring_net

echo postgres | docker secret create db_user -
echo StrongPass123 | docker secret create db_password -

docker stack deploy -c docker-compose.yml voting

## How to Test the Platform
- Verify services
docker service ls
docker stack ps voting
- Test application
curl https://app.example.com
curl https://app.example.com/api/health
- Check monitoring
docker service ls | grep prometheus
docker service ls | grep grafana

## Swarm-Specific Considerations & Trade-offs

Why Swarm?

 Docker Swarm provides:

 Native clustering

 Built-in service discovery

 Rolling updates

 Secrets management

 Simpler operational model than Kubernetes

- Trade-offs vs Kubernetes

| Swarm | Kubernetes |
| ------| ---------- |
| Simple setup | More complex   |
| Built-in routing | Needs Ingress  |
| Limited ecosystem | Large ecosystem |
|	Fewer policies | Advanced network policies |


- Swarm is excellent for:

  - Small to mid-size clusters

  - Rapid deployments

  - Teams without Kubernetes expertise

  ## Migration Strategy Rationale
  The migration to Kubernetes uses a phased approach to avoid downtime.

Reasons:

Swarm and Kubernetes can run in parallel

DNS cutover allows rollback

Data integrity is preserved

Key mappings:

Swarm services → Kubernetes Deployments

Swarm secrets → Kubernetes Secrets

Overlay networks → CNI & Network Policies

Traefik → Kubernetes Ingress

This allows gradual validation before full cutover.
	
	
	
	