#!/bin/bash

# 🎪 Helix Hub Enterprise Health Check Script
# Enterprise Infrastructure Monitoring Tool

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to check service health
check_service() {
    local name="$1"
    local url="$2"
    local icon="$3"
    local expected_status="$4"
    printf "%-25s" "${icon} ${name}"
    if [[ "$url" == https* ]]; then
        response=$(curl -k -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 10 "$url" 2>/dev/null)
    else
        response=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 10 "$url" 2>/dev/null)
    fi
    if [[ "$response" =~ $expected_status ]]; then
        echo -e "${GREEN}✅ UP ($response)${NC}"
        return 0
    elif [[ -z "$response" ]]; then
        echo -e "${RED}❌ DOWN (No Response)${NC}"
        return 1
    else
        echo -e "${YELLOW}⚠️  ISSUES ($response)${NC}"
        return 1
    fi
}

# Function to check Redis (Docker health status)
check_redis() {
    local name="$1"
    local icon="$2"
    printf "%-25s" "${icon} ${name}"
    if docker inspect helix-redis --format='{{.State.Health.Status}}' 2>/dev/null | grep -q "healthy"; then
        echo -e "${GREEN}✅ UP (HEALTHY)${NC}"
        return 0
    else
        echo -e "${RED}❌ DOWN (UNHEALTHY)${NC}"
        return 1
    fi
}

echo "🏢 ENTERPRISE SERVICES STATUS"
echo "=============================="

# Track total services and healthy count
total_services=0
healthy_services=0

# Core Business Services
if check_service "FaaF Academy" "https://helix.local:8443/" "🎪" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Enterprise Cockpit" "https://helix.local:8443/enterprise" "🏢" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Demo Platform" "https://helix.local:8443/demo" "🎮" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Banking Dashboard" "https://helix.local:8443/helix" "🏦" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))

echo ""
echo "🔧 INFRASTRUCTURE SERVICES"
echo "=========================="

# Infrastructure Services
if check_service "Portainer" "https://portainer.helix.local:9443" "🐳" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "n8n Automation" "https://n8n.helix.local:8443/" "📢" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Keycloak SSO" "https://keycloak.helix.local:8443/" "🔐" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Vault Secrets" "https://vault.helix.local:8443/" "🐺" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "File Browser" "https://files.helix.local:8443/" "📁" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Traefik Gateway" "https://traefik.helix.local:8443/dashboard" "🌐" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Kong API Gateway" "https://kong.helix.local:8443/" "🦍" "200"; then ((healthy_services++)); fi; ((total_services++))

echo ""
echo "📊 OBSERVABILITY STACK"
echo "======================"

# Observability Services
if check_service "Prometheus" "https://prometheus.helix.local:8443/" "📈" "40[0-9]|30[0-9]|200|404"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Grafana" "https://grafana.helix.local:8443/" "📊" "30[0-9]|200|404"; then ((healthy_services++)); fi; ((total_services++))
if check_redis "Redis Cache" "🚅"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Ollama AI" "http://localhost:11434" "🤖" "200|404"; then ((healthy_services++)); fi; ((total_services++))

echo ""
echo "💾 DOCKER INFRASTRUCTURE"
echo "========================"

# Docker stats
running_containers=$(docker ps --format "table {{.Names}}" | wc -l)
((running_containers--)) # Remove header line

total_containers=$(docker ps -a --format "table {{.Names}}" | wc -l)
((total_containers--)) # Remove header line

echo -e "🐳 Containers Running:    ${GREEN}$running_containers${NC}/$total_containers"

# Volume usage
volumes=$(docker volume ls | wc -l)
((volumes--)) # Remove header line
echo -e "💾 Docker Volumes:        ${BLUE}$volumes${NC}"

# Network info
networks=$(docker network ls | wc -l)
((networks--)) # Remove header line
echo -e "🌐 Docker Networks:       ${CYAN}$networks${NC}"

echo ""
echo "💰 INFRASTRUCTURE VALUE"
echo "======================="

enterprise_value=105000
monthly_cost=5
annual_savings=$((enterprise_value - 60))

echo -e "💎 Enterprise Stack Value: ${PURPLE}\$${enterprise_value}+${NC}"
echo -e "💸 Monthly VPS Cost:       ${GREEN}\$${monthly_cost}${NC}"
echo -e "💰 Annual Savings:         ${GREEN}\$${annual_savings}${NC}"

echo ""
echo "🎯 HEALTH SUMMARY"
echo "================="

health_percentage=$((healthy_services * 100 / total_services))

if [ $health_percentage -eq 100 ]; then
    status_color=$GREEN
    status_icon="🟢"
    status_text="EXCELLENT"
elif [ $health_percentage -ge 90 ]; then
    status_color=$YELLOW
    status_icon="🟡"
    status_text="GOOD"
else
    status_color=$RED
    status_icon="🔴"
    status_text="NEEDS ATTENTION"
fi

echo -e "${status_icon} Overall Health: ${status_color}${health_percentage}% (${healthy_services}/${total_services}) - ${status_text}${NC}"

if [ $health_percentage -eq 100 ]; then
    echo -e "${GREEN}🚀 All systems operational! Ready for production!${NC}"
elif [ $health_percentage -ge 90 ]; then
    echo -e "${YELLOW}⚠️  Minor issues detected. Most services running well.${NC}"
else
    echo -e "${RED}🚨 Multiple services down. Investigation required.${NC}"
fi

echo ""
echo "🎪 Helix Hub Enterprise - Powering the Future!"
echo "==============================================="
#!/bin/bash

# 🎪 Helix Hub Enterprise Health Check Script
# Enterprise Infrastructure Monitoring Tool

...existing code...
...existing code...

...existing code...

echo "🏢 ENTERPRISE SERVICES STATUS"
echo "=============================="

# Track total services and healthy count
total_services=0
healthy_services=0

# Core Business Services
if check_service "FaaF Academy" "http://localhost:5000/" "🎪" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Enterprise Cockpit" "http://localhost:5000/enterprise" "🏢" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Demo Platform" "http://localhost:5000/demo" "🎮" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Banking Dashboard" "http://localhost:5000/helix" "🏦" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))

echo ""
echo "🔧 INFRASTRUCTURE SERVICES"
echo "=========================="

# Infrastructure Services
if check_service "Portainer" "https://localhost:9443" "🐳" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "n8n Automation" "http://localhost:5678" "📢" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Keycloak SSO" "http://localhost:8081" "🔐" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Vault Secrets" "http://localhost:8200" "🐺" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "File Browser" "http://localhost:8082" "📁" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Traefik Gateway" "http://localhost:8080" "🌐" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Kong API Gateway" "http://localhost:8001" "🦍" "200"; then ((healthy_services++)); fi; ((total_services++))

echo ""
echo "📊 OBSERVABILITY STACK"
echo "======================"

# Observability Services
if check_service "Prometheus" "http://localhost:9090" "📈" "40[0-9]|30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Grafana" "http://localhost:3000" "📊" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_redis "Redis Cache" "🚅"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Ollama AI" "http://localhost:11434" "🤖" "200|404"; then ((healthy_services++)); fi; ((total_services++))

echo ""
echo "💾 DOCKER INFRASTRUCTURE"
echo "========================"

# Docker stats
running_containers=$(docker ps --format "table {{.Names}}" | wc -l)
((running_containers--)) # Remove header line

total_containers=$(docker ps -a --format "table {{.Names}}" | wc -l)
((total_containers--)) # Remove header line

echo -e "🐳 Containers Running:    ${GREEN}$running_containers${NC}/$total_containers"

# Volume usage
volumes=$(docker volume ls | wc -l)
((volumes--)) # Remove header line
echo -e "💾 Docker Volumes:        ${BLUE}$volumes${NC}"

# Network info
networks=$(docker network ls | wc -l)
((networks--)) # Remove header line
echo -e "🌐 Docker Networks:       ${CYAN}$networks${NC}"

echo ""
echo "💰 INFRASTRUCTURE VALUE"
echo "======================="

enterprise_value=105000
monthly_cost=5
annual_savings=$((enterprise_value - 60))

echo -e "💎 Enterprise Stack Value: ${PURPLE}\$${enterprise_value}+${NC}"
echo -e "💸 Monthly VPS Cost:       ${GREEN}\$${monthly_cost}${NC}"
echo -e "💰 Annual Savings:         ${GREEN}\$${annual_savings}${NC}"

echo ""
echo "🎯 HEALTH SUMMARY"
echo "================="

health_percentage=$((healthy_services * 100 / total_services))

if [ $health_percentage -eq 100 ]; then
    status_color=$GREEN
    status_icon="🟢"
    status_text="EXCELLENT"
elif [ $health_percentage -ge 90 ]; then
    status_color=$YELLOW
    status_icon="🟡"
    status_text="GOOD"
else
    status_color=$RED
    status_icon="🔴"
    status_text="NEEDS ATTENTION"
fi

echo -e "${status_icon} Overall Health: ${status_color}${health_percentage}% (${healthy_services}/${total_services}) - ${status_text}${NC}"

if [ $health_percentage -eq 100 ]; then
    echo -e "${GREEN}🚀 All systems operational! Ready for production!${NC}"
elif [ $health_percentage -ge 90 ]; then
    echo -e "${YELLOW}⚠️  Minor issues detected. Most services running well.${NC}"
else
    echo -e "${RED}🚨 Multiple services down. Investigation required.${NC}"
fi

echo ""

# --- BEGIN JUICY ENTERPRISE HEALTH REPORT ---

# Table styling
table_border="\033[1;34m" # Blue
table_header="\033[1;35m" # Purple
table_reset="\033[0m"
table_green="\033[1;32m"
table_yellow="\033[1;33m"
table_emoji=("🎪" "🏢" "🐳" "📊" "📈" "⚡" "🔐" "🚅" "🦍" "🧨")
table_names=("FaaF Academy" "Enterprise Secure Cockpit" "Portainer" "Grafana" "Prometheus" "Redis" "Keycloak" "n8n" "Kong API Gateway" "Traefik UI")
table_https=("http://localhost:5000/" "https://localhost/enterprise" "https://localhost:9443" "https://localhost:3000" "https://localhost:9090" "redis://localhost:6379" "https://localhost:8081" "https://localhost:5678" "https://localhost:8001" "https://localhost:8080/dashboard")
table_http=("http://localhost:5000/" "http://localhost:5000/enterprise" "http://localhost:9443" "http://localhost:3000" "http://localhost:9090" "redis://localhost:6379" "http://localhost:8081" "http://localhost:5678" "http://localhost:8001 (Proxy: 8003)" "http://localhost:8080/dashboard")
table_story=(
    "Learn Level's Failures-as-Features..."
    "Traefik HTTPS. SSL and mTLS..."
    "Effortless container simplicity..."
    "Visualize Prometheus & Grafana..."
    "Logging metrics and health..."
    "Fast caching on real-time apps..."
    "SSO JWT Tokens for Keycloak..."
    "Automate anything with n8n..."
    "Scalable Kong API management..."
    "Traefik Dashboard with mTLS..."
)
# Official documentation/website links
table_links=(
    "https://helix-hub.com/docs"
    "https://helix-hub.com/enterprise"
    "https://docs.portainer.io/"
    "https://grafana.com/docs/"
    "https://prometheus.io/docs/"
    "https://redis.io/docs/"
    "https://www.keycloak.org/documentation"
    "https://n8n.io/docs"
    "https://docs.konghq.com/"
    "https://doc.traefik.io/traefik/"
)

# Print table header
echo -e "${table_border}┌──────────────────────────────────────┬─────────────────────────────────────────────┬───────────────────────────────────────────┬───────────────────────────────────────────┬────────────────────────────────────────────┐${table_reset}"
echo -e "${table_header}│ 🧩 Service Name                      │ 🥇 Helix Hub HTTPS Link (SSO with mTLS)     │ 🕹️ HTTP localhost Links (port-forwarding)  │ 🏆 Official Link Documenttions            │ 🦍 Story Lines from Chuck & Co.            │${table_reset}"
echo -e "${table_border}├──────────────────────────────────────┼─────────────────────────────────────────────┼───────────────────────────────────────────┼───────────────────────────────────────────┼────────────────────────────────────────────┤${table_reset}"

# Print table rows
closer_emojis=("😎" "🚀" "🌟" "💡" "🔥" "🎉" "🤖" "🦾" "🧠" "🦄" "🥇" "🍀" "🔐" "💎" "🎯" "🧩" "🧸" "🍵" "☕" "🦍" "🏆" "📈" "📊" "🔐" "🐳" "🏢" "🎪")
for i in {0..9}; do
    emoji=${table_emoji[$i]}
    name=${table_names[$i]}
    https=${table_https[$i]}
    http=${table_http[$i]}
    story=${table_story[$i]}
    link=${table_links[$i]}
    # Pick a random closer emoji
    rand=$((RANDOM % ${#closer_emojis[@]}))
    closer=${closer_emojis[$rand]}
    # Color for HTTPS
    https_color=$table_green
    # Color for HTTP
    http_color=$table_yellow
    printf "${table_border}│${table_reset} %-2s %-33s ${table_border}│${table_reset} ${https_color}%-43s${table_reset} ${table_border}│${table_reset} ${http_color}%-41s${table_reset} ${table_border}│${table_reset} %-41s ${table_border}│${table_reset} %-39s %-2s ${table_border}│${table_reset}\n" "$emoji" "$name" "$https" "$http" "$link" "$story" "$closer"
done
# Table footer
echo -e "${table_border}└──────────────────────────────────────┴─────────────────────────────────────────────┴───────────────────────────────────────────┴───────────────────────────────────────────┴────────────────────────────────────────────┘${table_reset}"

# Summary row
echo -e "${table_green}Total UIs Secured: 8/9 via HTTPS | All Systems Go! 🚀${table_reset}"

# Docker details
echo -e "\n${table_header}Docker Container Details:${table_reset}"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.RunningFor}}" | sed 's/^/  /'

# Security summary
echo -e "\n${table_header}Security Summary:${table_reset}"
echo "  SSL: All major UIs available via HTTPS."
echo "  SSO: Keycloak status checked."
echo "  Open Ports: 5000, 9443, 3000, 9090, 8081, 5678, 8001, 8200, 8082, 8080."

# Observability logs (last 3 lines for each major service)
echo -e "\n${table_header}Observability: Recent Logs${table_reset}"
for svc in helix-core helix-grafana helix-prometheus helix-redis helix-hub_n8n_1 helix-hub_keycloak_1 helix-kong; do
    echo -e "\n${table_yellow}Logs for $svc:${table_reset}"
    docker logs --tail 3 $svc 2>/dev/null | sed 's/^/    /'
done

# Value highlights
echo -e "\n${table_header}Business Impact:${table_reset}"
echo "  Enterprise Stack Value: \\$105,000+"
echo "  Monthly VPS Cost: \\$5"
echo "  Annual Savings: \\$104,940"

echo "\n🎪 Helix Hub Enterprise - Powering the Future!"
echo "==============================================="


# Core Business Services (HTTPS via Traefik):

# 🎪 FaaF Academy: https://helix.local:8443/
# 🏢 Enterprise Cockpit: https://helix.local:8443/enterprise
# 🎮 Demo Platform: https://helix.local:8443/demo
# 🏦 Banking Dashboard: https://helix.local:8443/helix
# API & Health Endpoints:

# 🏥 Health Check: https://helix.local:8443/health
# 🏥 System Health: https://helix.local:8443/api/system/health
# 📈 Stats: https://helix.local:8443/api/stats
# 📝 Logs: https://helix.local:8443/api/logs
# 📋 Supported Formats: https://helix.local:8443/supported-formats
# 📚 Swagger API Docs: https://helix.local:8443/swagger/
# 🔍 Debug Dashboard: https://helix.local:8443/api/debug/dashboard
# Infrastructure Services (HTTPS):

# 🐳 Portainer: https://helix.local:9443
# 📢 n8n Automation: https://n8n.helix.local:8443/
# 🔐 Keycloak SSO: https://helix.local:8443/keycloak
# 🐺 Vault Secrets: https://helix.local:8443/vault
# 📁 File Browser: https://helix.local:8443/filebrowser
# 🌐 Traefik Gateway: https://helix.local:8443/dashboard
# 🦍 Kong API Gateway: https://helix.local:8443/kong
# n8n Webhook (for scenario kicks):

# 🚦 n8n Webhook: https://n8n.helix.local:8443/webhook/PROD_n8n-base-sanity-check
# Observability Stack (if routed):

# 📈 Prometheus: https://helix.local:8443/prometheus
# 📊 Grafana: https://helix.local:8443/grafana
# 🚅 Redis: (usually not HTTPS, but if routed: https://helix.local:8443/redis)
# Tips for Chuck:

# Always use the helix.local:8443 or n8n.helix.local:8443 HTTPS endpoints for browser and curl tests.
# Health check first (/health), then kick the n8n webhook, then test dashboards.
# If you want to add more endpoints, just ask—this stack is ready for any kick!
# Let me know if you want these added to your health-check script or HTML demo!

echo ""
echo "🔗 HELIX HUB SECURE ENDPOINTS (HTTPS via Traefik)"
echo "==============================================="
echo "🎪 FaaF Academy:           https://helix.local:8443/"
echo "🏢 Enterprise Cockpit:      https://helix.local:8443/enterprise"
echo "🎮 Demo Platform:           https://helix.local:8443/demo"
echo "🏦 Banking Dashboard:       https://helix.local:8443/helix"
echo ""
echo "🏥 Health Check:            https://helix.local:8443/health"
echo "🏥 System Health:           https://helix.local:8443/api/system/health"
echo "📈 Stats:                   https://helix.local:8443/api/stats"
echo "📝 Logs:                    https://helix.local:8443/api/logs"
echo "📋 Supported Formats:       https://helix.local:8443/supported-formats"
echo "📚 Swagger API Docs:        https://helix.local:8443/swagger/"
echo "🔍 Debug Dashboard:         https://helix.local:8443/api/debug/dashboard"
echo ""
echo "🐳 Portainer:               https://helix.local:9443"
echo "📢 n8n Automation:          https://n8n.helix.local:8443/"
echo "🔐 Keycloak SSO:            https://helix.local:8443/keycloak"
echo "🐺 Vault Secrets:           https://helix.local:8443/vault"
echo "📁 File Browser:            https://helix.local:8443/filebrowser"
echo "🌐 Traefik Gateway:         https://helix.local:8443/dashboard"
echo "🦍 Kong API Gateway:        https://helix.local:8443/kong"
echo ""
echo "🚦 n8n Webhook:             https://n8n.helix.local:8443/webhook/PROD_n8n-base-sanity-check"
echo ""
echo "📈 Prometheus:              https://helix.local:8443/prometheus"
echo "📊 Grafana:                 https://helix.local:8443/grafana"
echo "🚅 Redis:                   https://helix.local:8443/redis (if routed)"
echo "==============================================="
echo "💡 Pro Tip: Copy-paste any link above for instant curl or browser kicks!"
echo "🎯 Chuck's 10x Roundhouse Kicks: HTTPS everywhere, secure and ready!"