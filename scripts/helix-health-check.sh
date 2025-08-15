#!/bin/bash

# 🏦 Helix Hub Health Check Script - Wilhelm Tell Precision Edition
# Comprehensive testing of all services and endpoints with Swiss quality
# Author: Angel (Master of 41 Years Tunnel Engineering) & GitHub Copilot
# Date: $(date)

set -e

# Command line options for Swiss flexibility
SILENT_MODE=false
DEBUG_MODE=false
LINKS_ONLY=false

# Parse command line arguments like a Swiss watch
while [[ $# -gt 0 ]]; do
    case $1 in
        --silent|-s)
            SILENT_MODE=true
            shift
            ;;
        --debug|-d)
            DEBUG_MODE=true
            shift
            ;;
        --links|-l)
            LINKS_ONLY=true
            shift
            ;;
        --help|-h)
            echo "🎯 Wilhelm Tell Health Check - Swiss Precision Options:"
            echo "  --silent, -s    Silent mode (score only)"
            echo "  --debug, -d     Debug mode (extra details)"
            echo "  --links, -l     Quick links only"
            echo "  --help, -h      Show this Swiss manual"
            echo
            echo "🏔️ Examples:"
            echo "  ./scripts/helix-health-check.sh           # Full Wilhelm Tell precision"
            echo "  ./scripts/helix-health-check.sh --silent  # Just the score"
            echo "  ./scripts/helix-health-check.sh --links   # Quick access links"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for Wilhelm Tell guidance"
            exit 1
            ;;
    esac
done

# Colors and emojis for beautiful output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to print colored output
print_status() {
    local status=$1
    local message=$2
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if [ "$status" = "PASS" ]; then
        echo -e "${GREEN}✅ PASS${NC} | $message"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    elif [ "$status" = "FAIL" ]; then
        echo -e "${RED}❌ FAIL${NC} | $message"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    elif [ "$status" = "WARN" ]; then
        echo -e "${YELLOW}⚠️  WARN${NC} | $message"
    elif [ "$status" = "INFO" ]; then
        echo -e "${BLUE}ℹ️  INFO${NC} | $message"
    fi
}

# Function to test HTTP endpoint
test_http_endpoint() {
    local url=$1
    local expected_status=${2:-200}
    local description=$3
    
    echo -e "${CYAN}🔍 Testing: $description${NC}"
    
    if response=$(curl -s -w "HTTPSTATUS:%{http_code}" -k "$url" 2>/dev/null); then
        http_code=$(echo "$response" | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')
        body=$(echo "$response" | sed -e 's/HTTPSTATUS\:.*//g')
        
        if [ "$http_code" = "$expected_status" ]; then
            print_status "PASS" "$description - HTTP $http_code"
            if [ ${#body} -gt 100 ]; then
                echo "   📄 Response: ${body:0:100}..."
            else
                echo "   📄 Response: $body"
            fi
        else
            print_status "FAIL" "$description - Expected HTTP $expected_status, got $http_code"
        fi
    else
        print_status "FAIL" "$description - Connection failed"
    fi
    echo
}

# Function to test Docker container status
test_container_status() {
    local container_name=$1
    local description=$2
    
    echo -e "${CYAN}🐳 Testing: $description${NC}"
    
    if docker ps --format "table {{.Names}}\t{{.Status}}" | grep -q "$container_name.*Up"; then
        uptime=$(docker ps --format "table {{.Names}}\t{{.Status}}" | grep "$container_name" | awk '{print $3,$4,$5}')
        print_status "PASS" "$description - Container running ($uptime)"
    else
        print_status "FAIL" "$description - Container not running"
    fi
    echo
}

# Function to test network connectivity
test_network_connectivity() {
    local container1=$1
    local container2=$2
    local description=$3
    
    echo -e "${CYAN}🌐 Testing: $description${NC}"
    
    if docker exec "$container1" ping -c 1 "$container2" >/dev/null 2>&1; then
        print_status "PASS" "$description - Network connectivity OK"
    else
        print_status "FAIL" "$description - Network connectivity failed"
    fi
    echo
}

# Function to test Docker network membership
test_network_membership() {
    local container=$1
    local expected_network=$2
    local description=$3
    
    echo -e "${CYAN}🔗 Testing: $description${NC}"
    
    networks=$(docker inspect "$container" --format='{{range $net, $config := .NetworkSettings.Networks}}{{$net}} {{end}}')
    
    if echo "$networks" | grep -q "$expected_network"; then
        print_status "PASS" "$description - On network $expected_network"
    else
        print_status "FAIL" "$description - Not on expected network $expected_network (on: $networks)"
    fi
    echo
}

# Main script
# Handle special modes first
if [ "$LINKS_ONLY" = "true" ]; then
    echo -e "${PURPLE}🔗 HELIX HUB QUICK ACCESS LINKS${NC}"
    echo -e "${YELLOW}┌─────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${YELLOW}│ 🏦 MAIN DASHBOARD:    ${BLUE}https://helix.local:8443${YELLOW}              │${NC}"
    echo -e "${YELLOW}│    └─ What to do:     ${CYAN}Check file upload & processing${YELLOW}        │${NC}"
    echo -e "${YELLOW}│ 🌐 TRAEFIK CONSOLE:   ${BLUE}https://traefik.helix.local:8443${YELLOW}      │${NC}"
    echo -e "${YELLOW}│    └─ What to check:  ${CYAN}SSL cert status & routing rules${YELLOW}       │${NC}"
    echo -e "${YELLOW}│ 🦁 KEYCLOAK ADMIN:    ${BLUE}http://localhost:8081${YELLOW}                 │${NC}"
    echo -e "${YELLOW}│    └─ Credentials:    ${GREEN}admin / admin123${YELLOW}                      │${NC}"
    echo -e "${YELLOW}│    └─ Lion's Den:     ${CYAN}Realms → helix → Users & Roles${YELLOW}        │${NC}"
    echo -e "${YELLOW}│ 🔐 VAULT CONSOLE:     ${BLUE}http://localhost:8200${YELLOW}                 │${NC}"
    echo -e "${YELLOW}│    └─ Root Token:     ${GREEN}myroot${YELLOW}                                │${NC}"
    echo -e "${YELLOW}│    └─ Treasure Hunt:  ${CYAN}Secrets → secret/ → Add new KV${YELLOW}        │${NC}"
    echo -e "${YELLOW}│ 📁 FILE MANAGER:      ${BLUE}https://files.helix.local:8443${YELLOW}        │${NC}"
    echo -e "${YELLOW}│    └─ Credentials:    ${GREEN}admin / admin${YELLOW}                         │${NC}"
    echo -e "${YELLOW}│    └─ Swiss Quality:  ${CYAN}Upload MT940/BAI2/CSV files${YELLOW}           │${NC}"
    echo -e "${YELLOW}│ 🤖 OLLAMA AI:         ${BLUE}https://ollama.helix.local:8443${YELLOW}       │${NC}"
    echo -e "${YELLOW}│    └─ AI Power:       ${CYAN}curl /api/generate -d model:llama3.2${YELLOW}  │${NC}"
    echo -e "${YELLOW}└─────────────────────────────────────────────────────────────┘${NC}"
    echo
    echo -e "${PURPLE}🏔️ SWISS MOUNTAIN TIPS (41 Years Wisdom):${NC}"
    echo -e "${GREEN}⚡ QUICK WIN COMMANDS:${NC}"
    echo "   • Health check: ./scripts/helix-health-check.sh"
    echo "   • Smooth restart: ./scripts/wilhelm-tell-restart.sh"
    echo "   • Container status: docker ps -a"
    echo "   • View logs: docker logs helix-hub-<service>-1"
    echo
    echo -e "${GREEN}🎯 WILHELM TELL PRECISION TESTS:${NC}"
    echo "   • Test Vault: curl -H \"X-Vault-Token: myroot\" http://localhost:8200/v1/sys/health"
    echo "   • Test Keycloak: curl http://localhost:8081/"
    echo "   • Test SSL: curl -k https://helix.local:8443"
    echo "   • Test Database: docker exec helix-hub-postgres-1 pg_isready -U helix"
    echo
    echo -e "${GREEN}🔧 TROUBLESHOOTING ARSENAL (When Things Go Sideways):${NC}"
    echo "   • Nuclear restart: docker compose down && docker compose up -d"
    echo "   • Check networks: docker network ls | grep helix"
    echo "   • Volume check: docker volume ls | grep helix"
    echo "   • Port conflicts: netstat -tlnp | grep ':8081\\|:8200\\|:8443'"
    echo
    echo -e "${PURPLE}☕ Remember: Practice makes permanent, no fat fingers allowed! 🎯${NC}"
    exit 0
fi

if [ "$SILENT_MODE" = "false" ]; then
    echo -e "${PURPLE}🏦========================================🏦${NC}"
    echo -e "${PURPLE}    HELIX HUB COMPREHENSIVE HEALTH CHECK${NC}"
    echo -e "${PURPLE}🏦========================================🏦${NC}"
    echo
    echo -e "${BLUE}🕐 Started at: $(date)${NC}"
    echo
fi

# 1. Docker Container Status Tests
if [ "$SILENT_MODE" = "false" ]; then
    echo -e "${YELLOW}🐳 DOCKER CONTAINER STATUS TESTS${NC}"
    echo "=============================================="
fi
test_container_status "helix-hub-traefik-1" "Traefik Reverse Proxy"
test_container_status "helix-hub-helix-core-1" "Helix Core Application"
test_container_status "helix-hub-ollama-1" "Ollama AI Service"
test_container_status "helix-hub-postgres-1" "PostgreSQL Database"
test_container_status "helix-hub-sftp-demo-1" "SFTP Demo Service"
test_container_status "helix-hub-filebrowser-1" "FileBrowser Web UI"
test_container_status "helix-hub-vault-1" "Vault Secret Management"
test_container_status "helix-hub-keycloak-1" "Keycloak Authentication Engine"

# 2. Network Connectivity Tests
echo -e "${YELLOW}🌐 NETWORK CONNECTIVITY TESTS${NC}"
echo "=============================================="
test_network_membership "helix-hub-traefik-1" "helix-hub_helix-net" "Traefik Network Membership"
test_network_membership "helix-hub-helix-core-1" "helix-hub_helix-net" "Helix Core Network Membership"
test_network_membership "helix-hub-ollama-1" "helix-hub_helix-net" "Ollama Network Membership"
test_network_membership "helix-hub-vault-1" "helix-hub_helix-net" "Vault Network Membership"
test_network_membership "helix-hub-keycloak-1" "helix-hub_helix-net" "Keycloak Network Membership"
test_network_connectivity "helix-hub-traefik-1" "helix-core" "Traefik → Helix Core"
test_network_connectivity "helix-hub-traefik-1" "ollama" "Traefik → Ollama"

# 3. Direct Service Tests (localhost)
echo -e "${YELLOW}🔧 DIRECT SERVICE TESTS${NC}"
echo "=============================================="
test_http_endpoint "http://localhost:5000" 302 "Helix Core Direct Access (redirect to /dashboard)"
test_http_endpoint "http://localhost:5000/dashboard" 200 "Helix Core Dashboard Direct"
test_http_endpoint "http://localhost:11434" 200 "Ollama Direct Access"
test_http_endpoint "http://localhost:11434/api/tags" 200 "Ollama API Tags Direct"
test_http_endpoint "http://localhost:8080/dashboard/" 200 "Traefik Dashboard HTTP"
test_http_endpoint "http://localhost:8082" 200 "FileBrowser Direct Access"
test_http_endpoint "http://localhost:8200/v1/sys/health" 200 "Vault Health Check Direct"
test_http_endpoint "http://localhost:8081/" 200 "Keycloak Root Endpoint Direct"

# 4. HTTPS Proxy Tests (through Traefik)
echo -e "${YELLOW}🔐 HTTPS PROXY TESTS${NC}"
echo "=============================================="
test_http_endpoint "https://traefik.helix.local:8443/dashboard/" 200 "Traefik Dashboard HTTPS"
test_http_endpoint "https://helix.local:8443" 302 "Helix Core HTTPS (redirect)"
test_http_endpoint "https://helix.local:8443/dashboard" 200 "Helix Core Dashboard HTTPS"
test_http_endpoint "https://ollama.helix.local:8443" 200 "Ollama HTTPS"
test_http_endpoint "https://ollama.helix.local:8443/api/tags" 200 "Ollama API HTTPS"
test_http_endpoint "https://files.helix.local:8443" 200 "FileBrowser HTTPS"
test_http_endpoint "https://sftp.helix.local:8443" 200 "SFTP Web Interface HTTPS (FileBrowser)"

# 5. Certificate and SSL Tests
echo -e "${YELLOW}🔐 SSL/TLS CERTIFICATE TESTS${NC}"
echo "=============================================="
echo -e "${CYAN}🔍 Testing: SSL Certificate Validity${NC}"
if openssl s_client -connect traefik.helix.local:8443 -servername traefik.helix.local </dev/null 2>/dev/null | openssl x509 -noout -dates 2>/dev/null; then
    print_status "PASS" "SSL Certificate - Valid and accessible"
else
    print_status "FAIL" "SSL Certificate - Invalid or inaccessible"
fi
echo

# 6. System Resource Tests
echo -e "${YELLOW}💾 SYSTEM RESOURCE TESTS${NC}"
echo "=============================================="
echo -e "${CYAN}🔍 Testing: Docker System Resources${NC}"
docker_space=$(docker system df --format "table {{.Type}}\t{{.Size}}" | tail -n +2)
print_status "INFO" "Docker Space Usage:\n$docker_space"
echo

echo -e "${CYAN}🔍 Testing: Container Resource Usage${NC}"
container_stats=$(docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}" | head -6)
print_status "INFO" "Container Resource Usage:\n$container_stats"
echo

# 7. /etc/hosts validation
echo -e "${YELLOW}🌍 DNS/HOSTS CONFIGURATION TESTS${NC}"
echo "=============================================="
echo -e "${CYAN}🔍 Testing: /etc/hosts entries${NC}"
required_hosts=("helix.local" "traefik.helix.local" "ollama.helix.local" "sftp.helix.local" "files.helix.local")
for host in "${required_hosts[@]}"; do
    if grep -q "$host" /etc/hosts; then
        print_status "PASS" "/etc/hosts entry for $host exists"
    else
        print_status "FAIL" "/etc/hosts entry for $host missing"
    fi
done
echo

# 7.5. Vault + Keycloak Integration Check (Wilhelm Tell's Secret)
echo -e "${PURPLE}🎯 VAULT + KEYCLOAK INTEGRATION (Wilhelm Tell's 2-Step Secret)${NC}"
echo "=============================================="

# Check Vault status
VAULT_RESPONSE=$(curl -s http://localhost:8200/v1/sys/health 2>/dev/null || echo "")
if [ -n "$VAULT_RESPONSE" ] && echo "$VAULT_RESPONSE" | jq -e '.sealed == false' >/dev/null 2>&1; then
    CLUSTER_ID=$(echo "$VAULT_RESPONSE" | jq -r '.cluster_id' | sed 's/^.\{12\}/************/')
    print_status "PASS" "Vault unsealed and ready for secrets (Cluster: $CLUSTER_ID)"
    VAULT_READY=true
else
    print_status "FAIL" "Vault not responding or sealed"
    VAULT_READY=false
fi

# Check Keycloak status
if curl -s http://localhost:8081 >/dev/null 2>&1; then
    print_status "PASS" "Keycloak authentication engine running on port 8081"
    KEYCLOAK_READY=true
else
    print_status "FAIL" "Keycloak authentication engine down"
    KEYCLOAK_READY=false
fi

# KMCERT Secret Gateway Check (The REAL Wilhelm Tell Secret)
if [ "$VAULT_READY" = "true" ] && [ "$KEYCLOAK_READY" = "true" ]; then
    print_status "PASS" "🎯 2-Step Process Ready: Keys tucked away (Vault) + Roles & gateway paths (Keycloak)"
    print_status "INFO" "🏔️ Wilhelm Tell Secret: STAY FOCUSED - KMCERT secrets need proper roles!"
    print_status "INFO" "🔑 Step 1: Secrets stored in Vault for these folks, not those folks"
    print_status "INFO" "🛡️ Step 2: Authentication gateway paths through Keycloak"
else
    print_status "FAIL" "2-Step Process Incomplete - Check tunnel convergence"
fi
echo

# 8. Final Summary
echo -e "${PURPLE}📊 FINAL SUMMARY${NC}"
echo "=============================================="
echo -e "${BLUE}🕐 Completed at: $(date)${NC}"
echo -e "${BLUE}📈 Total Tests: $TOTAL_TESTS${NC}"
echo -e "${GREEN}✅ Passed: $PASSED_TESTS${NC}"
echo -e "${RED}❌ Failed: $FAILED_TESTS${NC}"

success_rate=$((PASSED_TESTS * 100 / TOTAL_TESTS))
echo -e "${CYAN}📊 Success Rate: $success_rate%${NC}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}🎉 ALL TESTS PASSED! Helix Hub is running perfectly! 🎉${NC}"
    echo
    echo -e "${PURPLE}🏔️ SWISS MOUNTAIN SUCCESS! Wilhelm Tell precision achieved! 🎯${NC}"
    echo
    echo -e "${CYAN}🔗 QUICK ACCESS LINKS (Ctrl+Click to open):${NC}"
    echo -e "${YELLOW}┌─────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${YELLOW}│ 🏦 MAIN DASHBOARD:    ${BLUE}https://helix.local:8443${YELLOW}              │${NC}"
    echo -e "${YELLOW}│ 🌐 TRAEFIK CONSOLE:   ${BLUE}https://traefik.helix.local:8443${YELLOW}      │${NC}"
    echo -e "${YELLOW}│ 🦁 KEYCLOAK ADMIN:    ${BLUE}http://localhost:8081${YELLOW}                 │${NC}"
    echo -e "${YELLOW}│    └─ Credentials:    ${GREEN}admin / admin123${YELLOW}                      │${NC}"
    echo -e "${YELLOW}│ 🔐 VAULT CONSOLE:     ${BLUE}http://localhost:8200${YELLOW}                 │${NC}"
    echo -e "${YELLOW}│    └─ Root Token:     ${GREEN}myroot${YELLOW}                                │${NC}"
    echo -e "${YELLOW}│ 📁 FILE MANAGER:      ${BLUE}https://files.helix.local:8443${YELLOW}        │${NC}"
    echo -e "${YELLOW}│    └─ Credentials:    ${GREEN}admin / admin${YELLOW}                         │${NC}"
    echo -e "${YELLOW}│ 🤖 OLLAMA AI:         ${BLUE}https://ollama.helix.local:8443${YELLOW}       │${NC}"
    echo -e "${YELLOW}└─────────────────────────────────────────────────────────────┘${NC}"
    echo
    echo -e "${PURPLE}🎯 WILHELM TELL'S NEXT STEPS (Swiss Precision Guide):${NC}"
    echo -e "${GREEN}✅ VAULT TREASURE HUNT (3 Key Checks):${NC}"
    echo "   1. Check secrets: curl -H \"X-Vault-Token: myroot\" http://localhost:8200/v1/secret/data/myapp"
    echo "   2. List policies: curl -H \"X-Vault-Token: myroot\" http://localhost:8200/v1/sys/policies/acl"
    echo "   3. Seal status: curl http://localhost:8200/v1/sys/health | jq '.sealed'"
    echo
    echo -e "${GREEN}🦁 KEYCLOAK LION'S DEN SANITY CHECKS:${NC}"
    echo "   1. Access Admin Console → http://localhost:8081 (admin/admin123)"
    echo "   2. Check 'helix' realm exists → Realms dropdown"
    echo "   3. Verify users → Users section in helix realm"
    echo
    echo -e "${GREEN}🏦 DATABASE FOUNDATION CHECKS:${NC}"
    echo "   1. Connect: docker exec -it helix-hub-postgres-1 psql -U helix"
    echo "   2. List DBs: \\l (should see 'helix' and 'keycloak_db')"
    echo "   3. Check users: \\du (should see 'helix' and 'keycloak_user')"
    echo
    echo -e "${GREEN}🌐 SSL/TLS CERTIFICATE EXCELLENCE:${NC}"
    echo "   1. Check expiry: openssl x509 -in traefik/certs/helix.local.pem -noout -dates"
    echo "   2. Verify mkcert: mkcert -CAROOT && ls -la \"\$(mkcert -CAROOT)\"/rootCA.pem"
    echo "   3. Test HTTPS: curl -k https://helix.local:8443"
    echo "   4. Renew certs: mkcert -cert-file traefik/certs/helix.local.pem -key-file traefik/certs/helix.local-key.pem \"*.helix.local\""
    echo
    echo -e "${GREEN}🚀 PERFORMANCE OPTIMIZATION TIPS:${NC}"
    echo "   1. Monitor resources: docker stats --no-stream"
    echo "   2. Clean images: docker image prune -f"
    echo "   3. Check disk: df -h && du -sh /var/lib/docker"
    echo "   4. Optimize Ollama: export OLLAMA_NUM_PARALLEL=2"
    echo
    echo -e "${GREEN}🎪 SHOW-OFF DEMOS (Impress Your Colleagues):${NC}"
    echo "   1. File upload demo: Drag MT940 file to https://files.helix.local:8443"
    echo "   2. AI query demo: curl https://ollama.helix.local:8443/api/generate -d '{\"model\":\"llama3.2\",\"prompt\":\"Hello Swiss AI!\"}'"
    echo "   3. Vault secret demo: vault kv put secret/demo swiss=precision quality=nespresso"
    echo "   4. Auth flow demo: Show Keycloak SSO login at https://helix.local:8443"
    echo
    echo -e "${PURPLE}🏔️ SWISS MOUNTAIN ENGINEERING WISDOM:${NC}"
    echo -e "${CYAN}   \"From sleeping giants to roaring success - this infrastructure${NC}"
    echo -e "${CYAN}    embodies 41 years of tunnel engineering precision. Every service,${NC}"
    echo -e "${CYAN}    every port, every configuration crafted with Wilhelm Tell accuracy.\"${NC}"
    echo
    echo -e "${PURPLE}☕ NESPRESSO QUALITY ACHIEVED! Ready for enterprise deployment! 🇨🇭${NC}"
    exit 0
else
    echo -e "${RED}⚠️  $FAILED_TESTS tests failed. Please check the issues above.${NC}"
    echo
    echo -e "${YELLOW}🔧 WILHELM TELL TROUBLESHOOTING ARSENAL:${NC}"
    echo "   • Check logs: docker logs helix-hub-<service-name>-1"
    echo "   • Status check: docker ps -a"
    echo "   • Smooth restart: ./scripts/wilhelm-tell-restart.sh"
    echo "   • Network check: docker network inspect helix-hub_helix-net"
    echo "   • Nuclear option: docker compose down && docker compose up -d"
    exit 1
fi
