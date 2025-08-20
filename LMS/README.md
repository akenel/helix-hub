# Helix Hub LMS Lessons Learned ☕️📚

Welcome to the LMS knowledge base! Here you'll find hard-won tips, gotchas, and best practices from our journey integrating Moodle with Docker, Traefik, and PostgreSQL.

## 🚀 Quick Wins
- **Switching Moodle DB:** Use PostgreSQL for better compatibility and performance. Clean up old MariaDB volumes before switching.
- **Postgres Users & Creds:** Always create a dedicated DB and user for Moodle. Test connectivity with `psql` inside the container.
- **Docker Compose Tips:** Double-check environment variables and `depends_on` blocks. Restart containers after major changes.
- **Traefik Routing:** Update `dynamic.yml` for new services and endpoints. Use health checks and endpoint scripts for QA.

## 🦸‍♂️ Gotchas
- Old DB volumes can block new DB initialization—remove them before switching engines.
- Moodle needs correct DB host, user, and password—check logs for connection errors.
- Traefik config changes require container restarts to take effect.

## ☕️ Pro Tips
- Use clear commit messages for infra changes.
- Document every major troubleshooting step.

# LMS Health Check & Service URLs

## Quick Health Check

After starting your stack, run:

```bash
./LMS/lms-health-check.sh
```

This script checks all major Helix services over HTTPS (Traefik TLS/mkcert), lists running containers, and shows recent Moodle logs.

## Service URLs

All services use HTTPS via Traefik and mkcert.  
Add these domains to your `/etc/hosts`:

```
127.0.0.1 moodle.helix.local keycloak.helix.local n8n.helix.local vault.helix.local grafana.helix.local openwebui.helix.local traefik.helix.local
```

Access services at:

- Moodle: [https://moodle.helix.local:8443](https://moodle.helix.local:8443)
- Keycloak: [https://keycloak.helix.local:8443](https://keycloak.helix.local:8443)
- N8N: [https://n8n.helix.local:8443](https://n8n.helix.local:8443)
- Vault: [https://vault.helix.local:8443](https://vault.helix.local:8443)
- Grafana: [https://grafana.helix.local:8443](https://grafana.helix.local:8443)
- OpenWebUI: [https://openwebui.helix.local:8443](https://openwebui.helix.local:8443)
- Traefik Dashboard: [https://traefik.helix.local:8443](https://traefik.helix.local:8443)

> **Tip:** The `-k` flag in curl allows connecting to self-signed TLS endpoints (mkcert).  
> Update the script and hosts file as you add/remove services.

## Troubleshooting

- If a service fails, check its logs with `docker compose logs <service> --tail 20`
- Make sure all domains are in `/etc/hosts`
- Restart Traefik and affected services after config changes

---


## 📋 Example: Postgres User Setup
```bash
# Inside postgres container
psql -U postgres
CREATE DATABASE moodle;
CREATE USER moodleuser WITH PASSWORD 'yourpassword';
GRANT ALL PRIVILEGES ON DATABASE moodle TO moodleuser;
```

## 📝 Add your own lessons below!

---
Feel free to contribute more tips, scripts, and fun facts. Every lesson saves a coffee!
