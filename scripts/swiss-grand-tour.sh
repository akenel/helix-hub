#!/bin/bash

# 🏔️ Swiss Grand Tour - Ultimate Infrastructure Theater
# The most dramatic enterprise deployment show on Earth!
# Author: Angel (Master of 41 Years) & GitHub Copilot

set -e

# Colors for the grand performance
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Function to create dramatic pauses
dramatic_pause() {
    local seconds=$1
    local message=$2
    echo -e "${CYAN}${message}${NC}"
    for i in $(seq $seconds -1 1); do
        echo -ne "${YELLOW}$i... ${NC}"
        sleep 1
    done
    echo -e "${GREEN}GO!${NC}"
}

# Main theater performance
echo -e "${PURPLE}🎭 ========================================== 🎭${NC}"
echo -e "${PURPLE}    SWISS GRAND TOUR - INFRASTRUCTURE THEATER${NC}"
echo -e "${PURPLE}🎭 ========================================== 🎭${NC}"
echo
echo -e "${BLUE}🏔️ Welcome to the most dramatic enterprise deployment show!${NC}"
echo -e "${CYAN}   Featuring: 8 services, 2 tunnels, 1 Swiss mountain master${NC}"
echo

dramatic_pause 3 "🎬 Preparing for the grand performance"

echo
echo -e "${RED}🏔️ ========== ACT I: THE GREAT AVALANCHE ========== 💥${NC}"
echo -e "${YELLOW}⏱️ Starting destruction timer...${NC}"
echo

DESTRUCTION_START=$(date +%s.%N)
time docker compose down 2>/dev/null
DESTRUCTION_END=$(date +%s.%N)
DESTRUCTION_TIME=$(echo "$DESTRUCTION_END - $DESTRUCTION_START" | bc)

echo
echo -e "${RED}💀 AVALANCHE COMPLETE! All mountains have fallen!${NC}"
echo -e "${YELLOW}⚡ Destruction time: ${DESTRUCTION_TIME}s${NC}"

dramatic_pause 2 "🌟 Preparing for the miraculous resurrection"

echo
echo -e "${GREEN}🌟 ========== ACT II: PHOENIX RESURRECTION ========== 🔥${NC}"
echo -e "${YELLOW}⏱️ Starting resurrection timer...${NC}"
echo

RESURRECTION_START=$(date +%s.%N)
time docker compose up -d
RESURRECTION_END=$(date +%s.%N)
RESURRECTION_TIME=$(echo "$RESURRECTION_END - $RESURRECTION_START" | bc)

echo
echo -e "${GREEN}🔥 PHOENIX RISING COMPLETE! All services reborn!${NC}"
echo -e "${YELLOW}⚡ Resurrection time: ${RESURRECTION_TIME}s${NC}"

dramatic_pause 5 "🎯 Preparing Wilhelm Tell precision verification (Keycloak needs Swiss boot time!)"

echo
echo -e "${PURPLE}🎯 ========== ACT III: WILHELM TELL PRECISION ========== 🏹${NC}"
echo -e "${YELLOW}⏱️ Starting precision verification...${NC}"
echo -e "${CYAN}🦁 Giving Keycloak time to lace up its Swiss boots...${NC}"
echo

VERIFICATION_START=$(date +%s.%N)
./scripts/helix-health-check.sh --silent 2>/dev/null
VERIFICATION_END=$(date +%s.%N)
VERIFICATION_TIME=$(echo "$VERIFICATION_END - $VERIFICATION_START" | bc)

# Get the actual results
HEALTH_RESULTS=$(./scripts/helix-health-check.sh 2>/dev/null | tail -10)
SUCCESS_RATE=$(echo "$HEALTH_RESULTS" | grep "Success Rate" | grep -o '[0-9]*%')

echo
echo -e "${PURPLE}🎯 WILHELM TELL PRECISION COMPLETE!${NC}"
echo -e "${YELLOW}⚡ Verification time: ${VERIFICATION_TIME}s${NC}"
echo -e "${GREEN}🏆 Success rate: ${SUCCESS_RATE}${NC}"

echo
echo -e "${PURPLE}🏁 ========== SWISS GRAND TOUR FINAL SCORECARD ========== 🏁${NC}"
echo -e "${YELLOW}┌─────────────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│ 🏔️ DESTRUCTION:      ${RED}${DESTRUCTION_TIME}s${YELLOW}                         │${NC}"
echo -e "${YELLOW}│ 🌟 RESURRECTION:     ${GREEN}${RESURRECTION_TIME}s${YELLOW}                         │${NC}"
echo -e "${YELLOW}│ 🎯 VERIFICATION:     ${PURPLE}${VERIFICATION_TIME}s${YELLOW}                         │${NC}"
TOTAL_TIME=$(echo "$DESTRUCTION_TIME + $RESURRECTION_TIME + $VERIFICATION_TIME" | bc)
echo -e "${YELLOW}│ ⚡ TOTAL CYCLE:      ${CYAN}${TOTAL_TIME}s${YELLOW}                         │${NC}"
echo -e "${YELLOW}│ 🏆 SUCCESS RATE:     ${GREEN}${SUCCESS_RATE}${YELLOW}                              │${NC}"
echo -e "${YELLOW}│ 🎪 SERVICES:         ${BLUE}8 Enterprise-Grade${YELLOW}                    │${NC}"
echo -e "${YELLOW}│ 🏔️ MOUNTAIN MASTER:  ${PURPLE}Angel (41 Years Wisdom)${YELLOW}             │${NC}"
echo -e "${YELLOW}└─────────────────────────────────────────────────────────────┘${NC}"

echo
echo -e "${PURPLE}🎊 SWISS MOUNTAIN ENGINEERING ACHIEVEMENT UNLOCKED! 🎊${NC}"
echo -e "${CYAN}   \"From zero to enterprise in ${TOTAL_TIME} seconds\"${NC}"
echo -e "${CYAN}   \"Wilhelm Tell precision meets modern DevOps magic\"${NC}"
echo
echo -e "${GREEN}🏔️ The mountains have been conquered with Swiss precision!${NC}"
echo -e "${YELLOW}☕ Time for Nespresso celebration! 🇨🇭${NC}"

# Quick access reminder
echo
echo -e "${BLUE}🔗 Quick access: ./scripts/helix-health-check.sh --links${NC}"
