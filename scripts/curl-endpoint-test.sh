#!/bin/bash
# Helix Hub Service Endpoint Curl Test Script
# This script tests both HTTP and HTTPS endpoints for all major services

SERVICES=(
  "helix.local:8443 helix.local:5000"
  "keycloak.helix.local:8443 keycloak:8080"
  "vault.helix.local:8443 vault:8200"
  "files.helix.local:8443 filebrowser:80"
  "n8n.helix.local:8443 n8n:5678"
  "traefik.helix.local:8443 traefik:8080"
  "kong.helix.local:8443 kong:8001"
  "portainer.helix.local:9443 portainer:9443"
  "grafana.helix.local:8443 grafana:3000"
  "prometheus.helix.local:8443 prometheus:9090"
)

for svc in "${SERVICES[@]}"; do
  https_url="${svc%% *}"
  http_url="${svc##* }"
  echo "\nTesting HTTPS: https://$https_url"
  curl -k -I --connect-timeout 5 --max-time 10 "https://$https_url"
  echo "\nTesting HTTP: http://$http_url"
  curl -I --connect-timeout 5 --max-time 10 "http://$http_url"
  echo "------------------------------------------------------"
done
