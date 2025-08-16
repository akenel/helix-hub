#!/bin/bash

# Sally-Proof Live Demo Script
# "Tunnel Through to the Other Side" Edition
# For when colleagues think you're showing them tricks! 🎭

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${PURPLE}🎭 SALLY-PROOF LIVE DEMONSTRATION${NC}"
echo -e "${PURPLE}=====================================${NC}"
echo -e "${YELLOW}⏰ Real-time proof starting at: $(date '+%H:%M:%S.%3N')${NC}"
echo

# Live container status with real-time timestamps
echo -e "${CYAN}🐳 LIVE CONTAINER STATUS (refreshing every 2 seconds)${NC}"
echo -e "${YELLOW}💡 Watch the 'Up' timestamps change in real-time!${NC}"
echo

for i in {1..5}; do
    echo -e "${BLUE}📊 Snapshot #$i at $(date '+%H:%M:%S')${NC}"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | while IFS= read -r line; do
        if [[ $line == *"NAMES"* ]]; then
            echo -e "${GREEN}$line${NC}"
        elif [[ $line == *"Up"* ]]; then
            # Extract the "Up" part and make it colorful
            if [[ $line == *"minutes"* ]]; then
                echo -e "$line" | sed "s/Up [0-9]* minutes/${YELLOW}⏰ &${NC}/g"
            elif [[ $line == *"hours"* ]]; then
                echo -e "$line" | sed "s/Up [0-9]* hours/${GREEN}🕐 &${NC}/g"
            elif [[ $line == *"seconds"* ]]; then
                echo -e "$line" | sed "s/Up [0-9]* seconds/${CYAN}⚡ &${NC}/g"
            else
                echo -e "$line" | sed "s/Up/${PURPLE}🚀 Up${NC}/g"
            fi
        else
            echo "$line"
        fi
    done
    echo
    
    if [ $i -lt 5 ]; then
        echo -e "${YELLOW}⏳ Waiting 2 seconds for timestamps to tick...${NC}"
        sleep 2
    fi
done

echo -e "${PURPLE}🔥 REAL-TIME PROCESS ACTIVITY${NC}"
echo -e "${YELLOW}📈 Watch CPU/Memory usage fluctuate live!${NC}"
echo
docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}" | while IFS= read -r line; do
    if [[ $line == *"CONTAINER"* ]]; then
        echo -e "${GREEN}$line${NC}"
    else
        # Colorize based on CPU usage
        if [[ $line =~ ([0-9]+\.[0-9]+)% ]]; then
            cpu_val=${BASH_REMATCH[1]}
            if (( $(echo "$cpu_val > 5.0" | bc -l) )); then
                echo -e "$line" | sed "s/${cpu_val}%/${RED}🔥 ${cpu_val}%${NC}/g"
            elif (( $(echo "$cpu_val > 1.0" | bc -l) )); then
                echo -e "$line" | sed "s/${cpu_val}%/${YELLOW}⚡ ${cpu_val}%${NC}/g"
            else
                echo -e "$line" | sed "s/${cpu_val}%/${GREEN}😴 ${cpu_val}%${NC}/g"
            fi
        else
            echo "$line"
        fi
    fi
done

echo
echo -e "${PURPLE}🌊 LIVE NETWORK ACTIVITY${NC}"
echo -e "${YELLOW}🔍 Real-time network I/O fluctuations${NC}"
echo
if command -v netstat >/dev/null 2>&1; then
    netstat -i | grep -E "(Iface|docker|eth)" | while IFS= read -r line; do
        if [[ $line == *"Iface"* ]]; then
            echo -e "${GREEN}$line${NC}"
        else
            echo -e "${CYAN}🌐 $line${NC}"
        fi
    done
elif command -v ss >/dev/null 2>&1; then
    # ss doesn't show the same 'Iface' header, provide a compact fallback
    ss -i | sed -n '1,200p' | while IFS= read -r line; do
        echo -e "${CYAN}🌐 $line${NC}"
    done
else
    echo -e "${YELLOW}⚠️  netstat/ss not installed — skipping detailed interface list${NC}"
fi

echo
echo -e "${PURPLE}💾 LIVE DISK I/O ACTIVITY${NC}"
echo -e "${YELLOW}📊 Docker volumes and container filesystem activity${NC}"
if command -v iostat >/dev/null 2>&1; then
    iostat -x 1 1 | tail -n +4 | while IFS= read -r line; do
        if [[ $line == *"Device"* ]]; then
            echo -e "${GREEN}$line${NC}"
        elif [[ $line != "" ]]; then
            echo -e "${BLUE}💿 $line${NC}"
        fi
    done
else
    echo -e "${YELLOW}⚠️  iostat not installed — showing disk usage instead:${NC}"
    df -h | sed -n '1,20p' | while IFS= read -r line; do
        echo -e "${BLUE}💿 $line${NC}"
    done
fi

echo
echo -e "${PURPLE}🎯 TUNNEL THROUGH TEST - Real API Responses${NC}"
echo -e "${YELLOW}🚀 Making live HTTP calls - can't fake these responses!${NC}"
echo

echo -e "${CYAN}🔍 Vault Health (with cluster ID):${NC}"
vault_response=$(curl -s http://localhost:8200/v1/sys/health) || vault_response=""
if [ -n "$vault_response" ]; then
    if command -v jq >/dev/null 2>&1; then
        cluster_id=$(echo "$vault_response" | jq -r '.cluster_id // "N/A"')
        sealed=$(echo "$vault_response" | jq -r '.sealed // "unknown"')
        echo "🔐 Cluster ID: $cluster_id | Sealed: $sealed | Time: $(date '+%T')"
    else
        # jq not available — print raw response (safer than failing)
        echo "$vault_response"
    fi
else
    echo -e "${RED}❌ Vault unreachable${NC}"
fi

echo -e "${CYAN}🔍 Ollama Models (live query):${NC}"
ollama_models=$(curl -s http://localhost:11434/api/tags)
if [ $? -eq 0 ]; then
    echo "$ollama_models" | jq -r '.models[] | "🤖 Model: " + .name + " | Size: " + (.size|tostring) + " bytes"'
else
    echo -e "${RED}❌ Ollama unreachable${NC}"
fi

echo
echo -e "${PURPLE}⚡ LIVE PROCESS INSPECTION${NC}"
echo -e "${YELLOW}🔬 Active processes inside containers (can't fake this!):${NC}"
echo

containers=("helix-hub-helix-core-1" "helix-hub-vault-1" "helix-hub-keycloak-1")
for container in "${containers[@]}"; do
    echo -e "${CYAN}📦 Inside $container:${NC}"
    docker exec "$container" ps aux 2>/dev/null | head -3 | while IFS= read -r line; do
        if [[ $line == *"PID"* ]]; then
            echo -e "  ${GREEN}$line${NC}"
        else
            echo -e "  ${BLUE}🔄 $line${NC}"
        fi
    done || echo -e "  ${RED}❌ Container not accessible${NC}"
    echo
done

echo -e "${PURPLE}🎪 FINALE - Live Log Streaming Sample${NC}"
echo -e "${YELLOW}📜 Last 3 log entries from each service (real timestamps):${NC}"
echo

for container in "${containers[@]}"; do
    echo -e "${CYAN}📋 Recent logs from $container:${NC}"
    docker logs --tail=3 --timestamps "$container" 2>/dev/null | while IFS= read -r line; do
        echo -e "  ${GREEN}📝 $line${NC}"
    done || echo -e "  ${RED}❌ No logs available${NC}"
    echo
done

echo -e "${PURPLE}🏔️ SWISS MOUNTAIN PROOF COMPLETE!${NC}"
echo -e "${YELLOW}⏰ Demo completed at: $(date '+%H:%M:%S.%3N')${NC}"
echo -e "${GREEN}🎯 Challenge Sally to fake THESE live API responses and process lists!${NC}"
echo -e "${CYAN}💡 Pro tip: Run this script multiple times - the timestamps will be different each time!${NC}"
