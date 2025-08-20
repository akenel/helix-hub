#!/bin/bash
# LMS Health Check Script ☕️🚦
# Run after successful Moodle install

set -e

echo -e "\n🔎 Checking Moodle HTTPS endpoint..."
curl -k -I https://moodle.helix.local:8443

echo -e "\n🔎 Checking Keycloak HTTPS endpoint..."
curl -k -I https://keycloak.helix.local:8443

echo -e "\n🔎 Checking N8N HTTPS endpoint..."
curl -k -I https://n8n.helix.local:8443

echo -e "\n🔎 Checking Vault HTTPS endpoint..."
curl -k -I https://vault.helix.local:8443

echo -e "\n🔎 Checking Grafana HTTPS endpoint..."
curl -k -I https://grafana.helix.local:8443

echo -e "\n🔎 Checking OpenWebUI HTTPS endpoint..."
curl -k -I https://openwebui.helix.local:8443

echo -e "\n🔎 Checking Traefik Dashboard HTTPS endpoint..."
curl -k -I https://traefik.helix.local:8443

echo -e "\n🔎 Listing running containers..."
docker compose ps

echo -e "\n🔎 Showing last 20 Moodle logs..."
docker compose logs moodle --tail 20

echo -e "\n🏁 Health check complete!"