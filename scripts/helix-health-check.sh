#!/bin/bash

# 🏦 Helix Hub Health Check Script
# Comprehensive testing of all services and endpoints
# Author: Angel & GitHub Copilot
# Date: $(date)

set -e

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
echo -e "${PURPLE}🏦========================================🏦${NC}"
echo -e "${PURPLE}    HELIX HUB COMPREHENSIVE HEALTH CHECK${NC}"
echo -e "${PURPLE}🏦========================================🏦${NC}"
echo
echo -e "${BLUE}🕐 Started at: $(date)${NC}"
echo

# 1. Docker Container Status Tests
echo -e "${YELLOW}🐳 DOCKER CONTAINER STATUS TESTS${NC}"
echo "=============================================="
test_container_status "helix-hub-traefik-1" "Traefik Reverse Proxy"
test_container_status "helix-hub-helix-core-1" "Helix Core Application"
test_container_status "helix-hub-ollama-1" "Ollama AI Service"
test_container_status "helix-hub-postgres-1" "PostgreSQL Database"
test_container_status "helix-hub-sftp-demo-1" "SFTP Demo Service"

# 2. Network Connectivity Tests
echo -e "${YELLOW}🌐 NETWORK CONNECTIVITY TESTS${NC}"
echo "=============================================="
test_network_membership "helix-hub-traefik-1" "helix-hub_helix-net" "Traefik Network Membership"
test_network_membership "helix-hub-helix-core-1" "helix-hub_helix-net" "Helix Core Network Membership"
test_network_membership "helix-hub-ollama-1" "helix-hub_helix-net" "Ollama Network Membership"
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

# 4. HTTPS Proxy Tests (through Traefik)
echo -e "${YELLOW}🔐 HTTPS PROXY TESTS${NC}"
echo "=============================================="
test_http_endpoint "https://traefik.helix.local:8443/dashboard/" 200 "Traefik Dashboard HTTPS"
test_http_endpoint "https://helix.local:8443" 302 "Helix Core HTTPS (redirect)"
test_http_endpoint "https://helix.local:8443/dashboard" 200 "Helix Core Dashboard HTTPS"
test_http_endpoint "https://ollama.helix.local:8443" 200 "Ollama HTTPS"
test_http_endpoint "https://ollama.helix.local:8443/api/tags" 200 "Ollama API HTTPS"

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
required_hosts=("helix.local" "traefik.helix.local" "ollama.helix.local" "sftp.helix.local")
for host in "${required_hosts[@]}"; do
    if grep -q "$host" /etc/hosts; then
        print_status "PASS" "/etc/hosts entry for $host exists"
    else
        print_status "FAIL" "/etc/hosts entry for $host missing"
    fi
done
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
    exit 0
else
    echo -e "${RED}⚠️  $FAILED_TESTS tests failed. Please check the issues above.${NC}"
    exit 1
fi
