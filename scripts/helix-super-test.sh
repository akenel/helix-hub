#!/bin/bash
# 🦍 Helix Hub Super Test Script
# Chuck: Browser links | Marcel: curl endpoints | All: Emojis & Pro Tips

# --- Browser Links (for Chuck) ---
cat <<EOF

================ HELIX HUB BROWSER LINKS ================
🎪 FaaF Academy:           https://helix.local:8443/
🏢 Enterprise Cockpit:      https://helix.local:8443/enterprise
🎮 Demo Platform:           https://helix.local:8443/demo
🏦 Banking Dashboard:       https://helix.local:8443/helix

🏥 Health Check:            https://helix.local:8443/health
🏥 System Health:           https://helix.local:8443/api/system/health
📈 Stats:                   https://helix.local:8443/api/stats
📝 Logs:                    https://helix.local:8443/api/logs
📋 Supported Formats:       https://helix.local:8443/supported-formats
📚 Swagger API Docs:        https://helix.local:8443/swagger/
🔍 Debug Dashboard:         https://helix.local:8443/api/debug/dashboard

🐳 Portainer:               https://helix.local:9443
📢 n8n Automation:          https://n8n.helix.local:8443/
🔐 Keycloak SSO:            https://helix.local:8443/keycloak
🐺 Vault Secrets:           https://helix.local:8443/vault
📁 File Browser:            https://helix.local:8443/filebrowser
🌐 Traefik Gateway:         https://helix.local:8443/dashboard
🦍 Kong API Gateway:        https://helix.local:8443/kong
🚦 n8n Webhook:             https://n8n.helix.local:8443/webhook/PROD_n8n-base-sanity-check
📈 Prometheus:              https://helix.local:8443/prometheus
📊 Grafana:                 https://helix.local:8443/grafana
🚅 Redis:                   https://helix.local:8443/redis (if routed)
🤖 Ollama AI:               https://ollama.helix.local:8443/
=========================================================

EOF

# --- Curl Endpoints (for Marcel) ---
ENDPOINTS=(
  "https://helix.local:8443/"
  "https://helix.local:8443/enterprise"
  "https://helix.local:8443/demo"
  "https://helix.local:8443/helix"
  "https://helix.local:8443/health"
  "https://helix.local:8443/api/system/health"
  "https://helix.local:8443/api/stats"
  "https://helix.local:8443/api/logs"
  "https://helix.local:8443/supported-formats"
  "https://helix.local:8443/swagger/"
  "https://helix.local:8443/api/debug/dashboard"
  "https://helix.local:9443"
  "https://n8n.helix.local:8443/"
  "https://keycloak.helix.local:8443/"
  "https://vault.helix.local:8443/"
  "https://files.helix.local:8443/"
  "https://traefik.helix.local:8443/dashboard"
  "https://kong.helix.local:8443/"
  "https://n8n.helix.local:8443/webhook/PROD_n8n-base-sanity-check"
  "https://prometheus.helix.local:8443/"
  "https://grafana.helix.local:8443/"
  "https://redis.helix.local:8443/"
  "https://ollama.helix.local:8443/"
)

for url in "${ENDPOINTS[@]}"; do
  emoji=""
  case "$url" in
    *faaf*) emoji="🎪";;
    *enterprise*) emoji="🏢";;
    *demo*) emoji="🎮";;
    *helix.local:8443/helix*) emoji="🏦";;
    *health*) emoji="🏥";;
    *stats*) emoji="📈";;
    *logs*) emoji="📝";;
    *formats*) emoji="📋";;
    *swagger*) emoji="📚";;
    *debug*) emoji="🔍";;
    *portainer*) emoji="🐳";;
    *n8n*) emoji="📢";;
    *keycloak*) emoji="🔐";;
    *vault*) emoji="🐺";;
    *filebrowser*) emoji="📁";;
    *traefik*) emoji="🌐";;
    *kong*) emoji="🦍";;
    *prometheus*) emoji="📈";;
    *grafana*) emoji="📊";;
    *redis*) emoji="🚅";;
    *ollama*) emoji="🤖";;
  esac
  echo -e "\n$emoji Curl: $url"
  curl -k -I --connect-timeout 5 --max-time 10 "$url"
  echo "------------------------------------------------------"
done

# --- Pro Tips ---
echo -e "\n💡 Pro Tip: Use browser for UI, curl for API/health. Copy-paste any link above for instant kicks!"
echo -e "🎯 Marcel's 10x Curl Kicks: HTTPS everywhere, secure and ready!"
echo -e "🥋 Chuck's Roundhouse: Test all links, then go for coffee!"
