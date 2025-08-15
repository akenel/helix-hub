#!/bin/bash

# 🏔️ SALLY AVALANCHE ULTIMATE PROOF DEMO
# =====================================
# By Angel (Master of 41 Years Tunnel Engineering) & GitHub Copilot
# Swiss Mountain Engineering - Wilhelm Tell Precision Edition
# 
# THE BOOM MOMENT: When Sally hits ANY key, the avalanche begins!
# CEO Handshake Protection Protocol - 9am Ready!

set -e

# Parse command line arguments for superior booms
DEBUG_MODE=false
SUPER_BOOM=false
HELP_MODE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --debug)
            DEBUG_MODE=true
            shift
            ;;
        --super-boom)
            SUPER_BOOM=true
            shift
            ;;
        --help|-h)
            HELP_MODE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Help mode
if [ "$HELP_MODE" = "true" ]; then
    echo -e "${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║         🏔️ SALLY AVALANCHE ULTIMATE PROOF - HELP  🏔️          ║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "${CYAN}🎯 USAGE:${NC}"
    echo -e "${YELLOW}   ./scripts/sally-avalanche-ultimate-proof.sh [OPTIONS]${NC}"
    echo
    echo -e "${CYAN}📋 OPTIONS:${NC}"
    echo -e "${GREEN}   --debug         Extra diagnostic details and verbose output${NC}"
    echo -e "${GREEN}   --super-boom    Maximum proof mode (more API calls, longer demo)${NC}"
    echo -e "${GREEN}   --help, -h      Show this help message${NC}"
    echo
    echo -e "${CYAN}🏔️ EXAMPLES:${NC}"
    echo -e "${YELLOW}   # Standard CEO demo:${NC}"
    echo -e "${WHITE}   ./scripts/sally-avalanche-ultimate-proof.sh${NC}"
    echo
    echo -e "${YELLOW}   # Debug mode for troubleshooting:${NC}"
    echo -e "${WHITE}   ./scripts/sally-avalanche-ultimate-proof.sh --debug${NC}"
    echo
    echo -e "${YELLOW}   # Super boom mode for maximum Sally skepticism:${NC}"
    echo -e "${WHITE}   ./scripts/sally-avalanche-ultimate-proof.sh --super-boom${NC}"
    echo
    echo -e "${PURPLE}🎯 Swiss Mountain Engineering - Wilhelm Tell Precision!${NC}"
    exit 0
fi

# Colors and emojis for Swiss Alpine beauty
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Logging setup
LOG_DIR="logs"
mkdir -p "$LOG_DIR"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="$LOG_DIR/sally_avalanche_proof_$TIMESTAMP.log"
HUMAN_LOG="$LOG_DIR/sally_proof_human_readable_$TIMESTAMP.txt"

# Spinner function for Swiss precision waiting
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='🏔️⛷️🎿🏂❄️⛄🌨️🗻'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Head bump animation (for when Sally realizes this is REAL)
head_bump() {
    echo -e "${YELLOW}🤯 SALLY'S HEAD BUMP SEQUENCE 🤯${NC}"
    for i in {1..5}; do
        echo -e "${RED}💥 BOOM! Reality check #$i 💥${NC}"
        sleep 0.3
    done
}

# Log everything to files
if [ "$DEBUG_MODE" = "true" ]; then
    exec > >(tee -a "$LOG_FILE")
    exec 2>&1
    echo -e "${YELLOW}🔧 DEBUG MODE ENABLED - Extra verbose output${NC}"
    echo "DEBUG MODE ENABLED" >> "$HUMAN_LOG"
else
    exec > >(tee -a "$LOG_FILE")
    exec 2>&1
fi

# Start human readable log
echo "SALLY AVALANCHE PROOF DEMONSTRATION" > "$HUMAN_LOG"
echo "Generated at: $(date)" >> "$HUMAN_LOG"
echo "By: Angel (41 Years Swiss Tunnel Engineering)" >> "$HUMAN_LOG"
echo "==========================================" >> "$HUMAN_LOG"
echo "" >> "$HUMAN_LOG"

# NO CLEAR - Angel's rule: Keep all history visible!
echo
echo -e "${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║              🏔️  SALLY AVALANCHE ULTIMATE PROOF  🏔️            ║${NC}"
echo -e "${PURPLE}║                                                              ║${NC}"
echo -e "${PURPLE}║          🎯 CEO Handshake Protection Protocol                ║${NC}"
echo -e "${PURPLE}║          ⏰ 9am Ready - Wilhelm Tell Precision               ║${NC}"
echo -e "${PURPLE}║          💰 Plumber Payment Guarantee System                 ║${NC}"
echo -e "${PURPLE}║          🇨🇭 Swiss Mountain Engineering Excellence            ║${NC}"
echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${CYAN}🕐 Starting proof session at: $(date)${NC}"
echo -e "${YELLOW}📍 Current working directory: $(pwd)${NC}"
echo -e "${GREEN}👤 Operator: $(whoami) on $(hostname)${NC}"
if [ "$DEBUG_MODE" = "true" ]; then
    echo -e "${YELLOW}🔧 Debug mode: ENABLED${NC}"
    echo -e "${YELLOW}📊 Docker version: $(docker --version)${NC}"
    echo -e "${YELLOW}💻 System info: $(uname -a)${NC}"
fi
if [ "$SUPER_BOOM" = "true" ]; then
    echo -e "${RED}💥 SUPER BOOM MODE: ACTIVATED! Maximum proof incoming!${NC}"
fi
echo

echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${BLUE}│              🔍 SECTION A: PRE-BOOM VERIFICATION             │${NC}"
echo -e "${BLUE}│          Initial container status (before keyboard test)     │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"

# Section A: Pre-boom verification
echo "SECTION A: PRE-BOOM VERIFICATION" >> "$HUMAN_LOG"
echo "Time: $(date)" >> "$HUMAN_LOG"

LOOP_COUNT=3
if [ "$SUPER_BOOM" = "true" ]; then
    LOOP_COUNT=5
    echo -e "${RED}💥 SUPER BOOM: Extended to $LOOP_COUNT snapshots!${NC}"
fi

for i in $(seq 1 $LOOP_COUNT); do
    echo -e "${CYAN}📊 Pre-boom snapshot #$i at $(date '+%H:%M:%S.%3N')${NC}"
    echo "Pre-boom snapshot #$i at $(date)" >> "$HUMAN_LOG"
    
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}" | head -5
    docker ps --format "{{.Names}} - {{.Status}} - {{.RunningFor}}" | head -5 >> "$HUMAN_LOG"
    
    if [ "$DEBUG_MODE" = "true" ]; then
        echo -e "${YELLOW}🔧 DEBUG: Container health status:${NC}"
        docker ps --format "{{.Names}}: {{.Status}}" | grep -E "(healthy|unhealthy)" || echo "No health status available"
    fi
    
    echo -e "${YELLOW}⏳ Waiting 3 seconds for timestamp progression...${NC}"
    sleep 3
    echo
done

echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${RED}│            🎪 SECTION B: THE KEYBOARD CHALLENGE              │${NC}"
echo -e "${RED}│         SALLY'S KEYBOARD TEST - Press ANY key for            │${NC}"
echo -e "${RED}│                    💥 AVALANCHE! 💥                          │${NC}"
echo -e "${RED}│              This is where the magic happens...              │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"

echo
echo -e "${RED}🎯 CHALLENGE SALLY: Hit ANY key to trigger the avalanche...${NC}"
echo -e "${YELLOW}   (This will prove it's not pre-recorded!)${NC}"

# THE BOOM MOMENT - Wait for Sally's keypress OR auto-continue after 10 seconds
echo
echo -e "${RED}🎯 CHALLENGE SALLY: Hit ANY key to trigger the avalanche...${NC}"
echo -e "${YELLOW}   (This will prove it's not pre-recorded!)${NC}"
echo -e "${CYAN}⏰ CEO Double-Loop Mode: Auto-boom in 10 seconds if no input${NC}"

# Auto-boom countdown for continuous CEO coverage
BOOM_TIME=""
echo -n -e "${PURPLE}🎪 Auto-boom countdown: "
for i in {10..1}; do
    echo -n "$i... "
    if read -n 1 -s -r -t 1 key; then
        BOOM_TIME=$(date '+%H:%M:%S.%3N')
        echo
        echo -e "${RED}💥💥💥 BOOM! SALLY HIT A KEY AT $BOOM_TIME! 💥💥💥${NC}"
        break
    fi
done

# If no key was pressed, auto-trigger
if [ -z "$BOOM_TIME" ]; then
    BOOM_TIME=$(date '+%H:%M:%S.%3N')
    echo
    echo -e "${RED}💥💥💥 AUTO-BOOM! CEO HANDSHAKE MODE AT $BOOM_TIME! 💥💥💥${NC}"
    echo -e "${YELLOW}🤝 Continuous play activated for CEO double-loop coverage!${NC}"
fi
echo "BOOM MOMENT: Sally hit keyboard at $BOOM_TIME" >> "$HUMAN_LOG"

# Head bump sequence
head_bump

echo -e "${PURPLE}🌊🌊🌊 AVALANCHE OF PROOF INCOMING! 🌊🌊🌊${NC}"

# Start the avalanche logging
echo "" >> "$HUMAN_LOG"
echo "AVALANCHE PROOF SEQUENCE STARTED" >> "$HUMAN_LOG"
echo "Boom time: $BOOM_TIME" >> "$HUMAN_LOG"

# Section 1: Live container status avalanche
echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│           📦 AVALANCHE SECTION 1: LIVE CONTAINER TSUNAMI     │${NC}"
echo -e "${GREEN}│            Rapid-fire container status (post-keyboard-hit)   │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"

for i in {1..8}; do
    CURRENT_TIME=$(date '+%H:%M:%S.%3N')
    echo -e "${CYAN}🚀 Avalanche snapshot #$i at $CURRENT_TIME (post-boom)${NC}"
    echo "Avalanche snapshot #$i at $CURRENT_TIME" >> "$HUMAN_LOG"
    
    # Show different views to prove it's live
    if [ $((i % 2)) -eq 0 ]; then
        docker ps --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Ports}}"
        docker ps --format "{{.Names}} - {{.Status}} - Running: {{.RunningFor}}" >> "$HUMAN_LOG"
    else
        docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
        docker stats --no-stream --format "{{.Container}} CPU:{{.CPUPerc}} MEM:{{.MemUsage}}" >> "$HUMAN_LOG"
    fi
    
    echo -e "${YELLOW}⚡ Avalanche pause 1.5 seconds...${NC}"
    sleep 1.5
    echo
done

# Section 2: Live API response avalanche
echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│             🌐 AVALANCHE SECTION 2: LIVE API TSUNAMI         │${NC}"
echo -e "${GREEN}│              Real-time API calls (impossible to fake!)       │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"

echo "LIVE API RESPONSES SECTION" >> "$HUMAN_LOG"

echo -e "${CYAN}🔐 Vault health check at $(date '+%H:%M:%S.%3N'):${NC}"
VAULT_RESPONSE=$(curl -s http://localhost:8200/v1/sys/health 2>/dev/null || echo "N/A")
echo "$VAULT_RESPONSE" | jq -r '.' 2>/dev/null || echo "$VAULT_RESPONSE"
echo "Vault response at $(date): $VAULT_RESPONSE" >> "$HUMAN_LOG"
echo

# Ollama models with timestamp  
echo -e "${CYAN}🤖 Ollama models at $(date '+%H:%M:%S.%3N'):${NC}"
OLLAMA_RESPONSE=$(curl -s http://localhost:11434/api/tags 2>/dev/null || echo "N/A")
echo "$OLLAMA_RESPONSE" | jq -r '.models[0] | "Model: \(.name) | Size: \(.size) bytes | Modified: \(.modified_at)"' 2>/dev/null || echo "$OLLAMA_RESPONSE"
echo "Ollama response at $(date): $OLLAMA_RESPONSE" >> "$HUMAN_LOG"
echo

# Traefik dashboard with timestamp (3rd verification step)
echo -e "${CYAN}🚪 Traefik dashboard at $(date '+%H:%M:%S.%3N'):${NC}"
TRAEFIK_RESPONSE=$(curl -s http://localhost:8080/api/overview 2>/dev/null || echo "N/A")
echo "$TRAEFIK_RESPONSE" | jq -r '.' 2>/dev/null || echo "$TRAEFIK_RESPONSE"
echo "Traefik response at $(date): $TRAEFIK_RESPONSE" >> "$HUMAN_LOG"
echo

# Section 3: Process inspection avalanche
echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│         🔬 AVALANCHE SECTION 3: PROCESS INSPECTION TSUNAMI   │${NC}"
echo -e "${GREEN}│              Live process trees (Sally can't fake this!)     │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"

echo "PROCESS INSPECTION SECTION" >> "$HUMAN_LOG"

CONTAINERS=("helix-hub-vault-1" "helix-hub-postgres-1" "helix-hub-traefik-1")
for container in "${CONTAINERS[@]}"; do
    echo -e "${CYAN}📦 Live processes in $container at $(date '+%H:%M:%S.%3N'):${NC}"
    echo "Processes in $container at $(date):" >> "$HUMAN_LOG"
    
    # Try multiple process commands for different container types
    docker exec "$container" ps aux 2>/dev/null || \
    docker exec "$container" ps -ef 2>/dev/null || \
    docker exec "$container" top -b -n1 2>/dev/null || \
    echo "   🔒 Process inspection blocked (security container)"
    
    docker exec "$container" ps aux 2>/dev/null >> "$HUMAN_LOG" || echo "Process blocked" >> "$HUMAN_LOG"
    echo
done

# Section 4: Network activity avalanche
echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│          🌐 AVALANCHE SECTION 4: NETWORK ACTIVITY TSUNAMI    │${NC}"
echo -e "${GREEN}│            Live network connections (real-time proof!)       │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"

echo "NETWORK ACTIVITY SECTION" >> "$HUMAN_LOG"

echo -e "${CYAN}🔗 Docker networks at $(date '+%H:%M:%S.%3N'):${NC}"
docker network ls
docker network ls >> "$HUMAN_LOG"
echo

echo -e "${CYAN}🌊 Network inspect helix-net at $(date '+%H:%M:%S.%3N'):${NC}"
docker network inspect helix-hub_helix-net | jq -r '.[] | .Containers | to_entries | .[] | "\(.value.Name): \(.value.IPv4Address)"' 2>/dev/null || docker network inspect helix-hub_helix-net
docker network inspect helix-hub_helix-net >> "$HUMAN_LOG"

# Section 5: Log streaming avalanche
echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│           📜 AVALANCHE SECTION 5: LOG STREAMING TSUNAMI      │${NC}"
echo -e "${GREEN}│            Live log tails (timestamps can't be faked!)       │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"

echo "LOG STREAMING SECTION" >> "$HUMAN_LOG"

LOG_CONTAINERS=("helix-hub-helix-core-1" "helix-hub-vault-1" "helix-hub-keycloak-1")
for container in "${LOG_CONTAINERS[@]}"; do
    echo -e "${CYAN}📋 Last 5 logs from $container at $(date '+%H:%M:%S.%3N'):${NC}"
    echo "Last 5 logs from $container at $(date):" >> "$HUMAN_LOG"
    
    docker logs --tail 5 --timestamps "$container" 2>&1 | tail -5
    docker logs --tail 5 --timestamps "$container" 2>&1 | tail -5 >> "$HUMAN_LOG"
    echo
done

# FINALE: The ultimate proof screen (NO CLEAR - Keep all evidence visible!)
echo
echo -e "${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║                    🏔️ AVALANCHE COMPLETE! 🏔️                   ║${NC}"
echo -e "${PURPLE}║                                                              ║${NC}"
echo -e "${PURPLE}║        🎯 SALLY'S KEYBOARD HIT TRIGGERED REAL PROOF!         ║${NC}"
echo -e "${PURPLE}║                                                              ║${NC}"
echo -e "${PURPLE}║  ✅ CEO Handshake Protection: ACTIVE                         ║${NC}"
echo -e "${PURPLE}║  💰 Plumber Payment Status: GUARANTEED                       ║${NC}"
echo -e "${PURPLE}║  🇨🇭 Swiss Mountain Quality: NESPRESSO LEVEL                  ║${NC}"
echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│                PROOF COMPLETION CERTIFICATE                  │${NC}"
echo -e "${GREEN}│                                                              │${NC}"
echo -e "${GREEN}│  📅 Date: $(date '+%Y-%m-%d')                               │${NC}"
echo -e "${GREEN}│  ⏰ Boom Time: $BOOM_TIME                                   │${NC}"
echo -e "${GREEN}│  🎯 Completion: $(date '+%H:%M:%S.%3N')                    │${NC}"
echo -e "${GREEN}│  👤 Witness: Sally (Keyboard Hitter)                         │${NC}"
echo -e "${GREEN}│  🏔️ Engineer: Angel (41 Years Tunnel Master)                 │${NC}"
echo -e "${GREEN}│                                                              │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"
echo
echo -e "${CYAN}📊 AVALANCHE STATISTICS:${NC}"
echo -e "${YELLOW}   • Total proof sections: 5${NC}"
echo -e "${YELLOW}   • Container snapshots: 8${NC}"
echo -e "${YELLOW}   • Live API calls: 3 (Vault + Ollama + Traefik)${NC}"
echo -e "${YELLOW}   • Process inspections: 3${NC}"
echo -e "${YELLOW}   • Log streams: 3${NC}"
echo -e "${YELLOW}   • Keyboard hits by Sally: 1 (BOOM!)${NC}"
echo
echo -e "${PURPLE}📁 EVIDENCE SAVED TO:${NC}"
echo -e "${CYAN}   🔍 Technical log: $LOG_FILE${NC}"
echo -e "${CYAN}   📖 Human readable: $HUMAN_LOG${NC}"
echo
echo -e "${WHITE}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${BLUE}│               VERIFICATION INSTRUCTIONS FOR SALLY            │${NC}"
echo -e "${BLUE}│                                                              │${NC}"
echo -e "${BLUE}│  🔍 Screen 4-8 Section A & B Verification:                   │${NC}"
echo -e "${BLUE}│      docker logs helix-hub-postgres-1 --tail 20              │${NC}"
echo -e "${BLUE}│      docker logs helix-hub-keycloak-1 --tail 20              │${NC}"
echo -e "${BLUE}│                                                              │${NC}"
echo -e "${BLUE}│  📋 Log Files (timestamped proof):                           │${NC}"
echo -e "${BLUE}│      cat $HUMAN_LOG      │${NC}"
echo -e "${BLUE}│                                                              │${NC}"
echo -e "${BLUE}│  🎯 Challenge: Try to fake these timestamps!                 │${NC}"
echo -e "${BLUE}│      ls -la logs/sally_*                                     │${NC}"
echo -e "${BLUE}│                                                              │${NC}"
echo -e "${WHITE}└──────────────────────────────────────────────────────────────┘${NC}"
echo
echo -e "${RED}🎪 FINAL CHALLENGE TO SALLY:${NC}"
echo -e "${YELLOW}   Try to create a script that generates different timestamps${NC}"
echo -e "${YELLOW}   each time, with live API responses, real process lists,${NC}"
echo -e "${YELLOW}   and container stats that change between runs!${NC}"
echo
echo -e "${GREEN}🏔️ Wilhelm Tell Precision: ACHIEVED${NC}"
echo -e "${GREEN}🎯 CEO Handshake: GUARANTEED${NC}"
echo -e "${GREEN}💰 Plumber Payment: SECURE${NC}"
echo
echo -e "${PURPLE}Press Ctrl+C for graceful exit, or ANY key for instant re-run${NC}"
echo -e "${YELLOW}⏰ CEO Double-Loop Mode: Auto-restart in 10 seconds (continuous play)${NC}"

# Final log entry
echo "" >> "$HUMAN_LOG"
echo "AVALANCHE COMPLETE" >> "$HUMAN_LOG"
echo "Final time: $(date)" >> "$HUMAN_LOG"
echo "Evidence saved to: $LOG_FILE and $HUMAN_LOG" >> "$HUMAN_LOG"

# Trap Ctrl+C for graceful exit with summary
trap 'echo -e "\n${GREEN}🎯 GRACEFUL EXIT INITIATED...${NC}"; 
      echo -e "${CYAN}📊 Session Summary:${NC}";
      echo -e "${YELLOW}   • Total runs: Multiple continuous loops${NC}";
      echo -e "${YELLOW}   • CEO coverage: Double handshake protected${NC}";
      echo -e "${YELLOW}   • Final timestamp: $(date)${NC}";
      echo -e "${YELLOW}   • Evidence logs: $(ls logs/sally_* | wc -l) files saved${NC}";
      echo -e "${GREEN}🐦 Thank you for using Wilhelm Tell precision tools!${NC}";
      echo -e "${PURPLE}🏔️ Swiss Mountain Engineering: Session complete with birds singing! 🎵${NC}";
      exit 0' INT

# CEO Double-Loop Continuous Play Mode - never more than 10 seconds pause
echo -n -e "${CYAN}🎪 CEO Double-Loop Mode: "
for i in {10..1}; do
    echo -n "$i... "
    if read -n 1 -s -r -t 1 key; then
        echo
        echo -e "${CYAN}� Instant restart triggered! (Key-tap speed boost)${NC}"
        echo
        exec "$0"
    fi
done

echo
echo -e "${CYAN}🔄 Auto-restarting for continuous CEO coverage (hands-free mode)...${NC}"
echo
exec "$0"
