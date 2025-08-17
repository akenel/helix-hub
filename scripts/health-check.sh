#!/bin/bash

# 🎪 Helix Hub Enterprise Health Check Script
# Enterprise Infrastructure Monitoring Tool

echo "🚀 HELIX HUB ENTERPRISE HEALTH CHECK"
echo "===================================="
echo "📅 $(date)"
echo ""

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
    local name=$1
    local url=$2
    local icon=$3
    local expected_status=$4
    
    printf "%-25s" "${icon} ${name}"
    
    # Use timeout to avoid hanging
    response=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 10 "$url" 2>/dev/null)
    
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

# Function to check Redis (TCP connection)
check_redis() {
    local name=$1
    local icon=$2
    
    printf "%-25s" "${icon} ${name}"
    
    if timeout 5 redis-cli -h localhost -p 6379 ping &>/dev/null; then
        echo -e "${GREEN}✅ UP (PONG)${NC}"
        return 0
    else
        echo -e "${RED}❌ DOWN (No PONG)${NC}"
        return 1
    fi
}

echo "🏢 ENTERPRISE SERVICES STATUS"
echo "=============================="

# Track total services and healthy count
total_services=0
healthy_services=0

# Core Business Services
if check_service "FaaF Academy" "http://localhost:5000/" "🎪" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Enterprise Dashboard" "http://localhost:5000/enterprise" "🏢" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Demo Platform" "http://localhost:5000/demo" "🎮" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Banking Dashboard" "http://localhost:5000/helix" "🏦" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))

echo ""
echo "🔧 INFRASTRUCTURE SERVICES"
echo "=========================="

# Infrastructure Services
if check_service "Portainer" "https://localhost:9443" "🐳" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "n8n Automation" "http://localhost:5678" "⚙️" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Keycloak SSO" "http://localhost:8081" "🔐" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Vault Secrets" "http://localhost:8200" "🗄️" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "File Browser" "http://localhost:8082" "📁" "200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Traefik Gateway" "http://localhost:8080" "🌐" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))

echo ""
echo "📊 OBSERVABILITY STACK"
echo "======================"

# Observability Services
if check_service "Prometheus" "http://localhost:9090" "📈" "40[0-9]|30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_service "Grafana" "http://localhost:3000" "📊" "30[0-9]|200"; then ((healthy_services++)); fi; ((total_services++))
if check_redis "Redis Cache" "⚡"; then ((healthy_services++)); fi; ((total_services++))
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

enterprise_value=80000
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
echo "🔗 QUICK ACCESS URLS"
echo "==================="
echo "🎪 FaaF Academy:        http://localhost:5000/"
echo "🏢 Enterprise Dashboard: http://localhost:5000/enterprise"
echo "🐳 Portainer:           https://localhost:9443"
echo "📊 Grafana:             http://localhost:3000"
echo "📈 Prometheus:          http://localhost:9090"
echo "⚡ Redis:               redis://localhost:6379"
echo "🔐 Keycloak:            http://localhost:8081"
echo "⚙️  n8n:                 http://localhost:5678"

echo ""
echo "🎪 Helix Hub Enterprise - Powering the Future!"
echo "==============================================="
