## Swarm Security Hardening

| Area               | Implementation                                  |
| ------------------ | ----------------------------------------------- |
| Secrets            | Swarm secrets mounted as files (`/run/secrets`) |
| Network            | Encrypted overlay networks                      |
| Image security     | Use official images + scan in CI                |
| Access control     | TLS + Portainer auth                            |
| Resource isolation | CPU & memory limits                             |
| Audit              | Docker logs + Fluentd                           |
| Node hardening     | Minimal OS, firewall, SSH keys                  |

## Production Readiness Checklist

| Area              | Implemented                        |
| ----------------- | ---------------------------------- |
| High Availability | Replicated services, multi-manager |
| Backup            | Swarm backup + DB volumes          |
| Monitoring        | Prometheus + Grafana               |
| Alerting          | Alertmanager                       |
| Logging           | Fluentd                            |
| Capacity          | Resource limits                    |
| Updates           | Rolling + rollback                 |
| Security          | TLS, secrets, scanning             |
