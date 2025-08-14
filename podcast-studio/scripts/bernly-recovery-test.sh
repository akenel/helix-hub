#!/bin/bash
# 🐕 Bernly Recovery Test - Optimized for Swiss Mountain Dog endurance!

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

BERNLY="🐕"
MOUNTAIN="🏔️"

echo -e "${BLUE}${BERNLY} BERNLY RECOVERY MODE - One rescue at a time! ${MOUNTAIN}${NC}"
echo

# Simplified prompt test
test_simple_prompt() {
    local name="$1"
    local description="$2"
    
    echo -e "${BLUE}${BERNLY} Testing: $description${NC}"
    
    start_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
    echo -e "${YELLOW}   Start: $start_time${NC}"
    
    # SIMPLIFIED PROMPT - Bernly-friendly!
    response=$(curl -s -X GET "http://localhost:5678/webhook-test/podcastStudioWF_v1" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"$name\",\"email\":\"test@test.com\",\"linkedin_text\":\"Professional with experience\"}")
    
    end_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
    echo -e "${YELLOW}   End:   $end_time${NC}"
    echo -e "${GREEN}   Response: $response${NC}"
    echo
    
    if [[ "$response" == *"Workflow was started"* ]]; then
        echo -e "${GREEN}${BERNLY} Bernly is on the case! Waiting 2 minutes for mountain rescue...${NC}"
        sleep 120
        echo -e "${GREEN}${BERNLY} Rescue mission complete! Next patient...${NC}"
        echo
    else
        echo -e "${RED}${BERNLY} Bernly needs help! Check n8n workflow.${NC}"
        echo
    fi
}

echo -e "${BLUE}🚨 BERNLY SEQUENTIAL RESCUE MISSIONS (No overload!)${NC}"
echo

test_simple_prompt "Jose Quick" "Quick Jose Test"
test_simple_prompt "Ilario Fast" "Fast Ilario Test"

echo -e "${GREEN}${BERNLY} All rescue missions complete! Bernly is tired but happy! ${MOUNTAIN}${NC}"
