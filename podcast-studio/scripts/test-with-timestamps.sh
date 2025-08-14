#!/bin/bash
# 🎪 Podcast Studio Test Script with Swiss Precision Timestamps
# Angel + Dr. Atlas timestamp debugging magic!

set -e

# Colors for beautiful output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

# Emojis for fun
COFFEE="☕"
ROCKET="🚀"
CLOCK="⏰"
CHECK="✅"

echo -e "${WHITE}${COFFEE}=====================================================================${COFFEE}${NC}"
echo -e "${WHITE}     PODCAST STUDIO ORACLE TEST - podcastStudioWF_v1${NC}"
echo -e "${WHITE}     Angel + Dr. Atlas + Swiss Mountain Dog Ollama Power!${NC}"
echo -e "${WHITE}${COFFEE}=====================================================================${COFFEE}${NC}"
echo

# Function to get Docker-formatted timestamp
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%S.%9NZ"
}

# Function to test webhook with timestamp
test_webhook() {
    local name="$1"
    local email="$2"
    local linkedin_text="$3"
    local description="$4"
    
    echo -e "${BLUE}${CLOCK} Testing: $description${NC}"
    
    # Get start timestamp
    start_time=$(get_timestamp)
    echo -e "${YELLOW}   Start Time: $start_time${NC}"
    
    # Make the request
    echo -e "${ROCKET} Calling n8n webhook..."
    URL="http://localhost:5678/webhook-test/podcastStudioWF_v1"
    response=$(curl -s -X GET "$URL" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"$name\",\"email\":\"$email\",\"linkedin_text\":\"$linkedin_text\",\"test_timestamp\":\"$start_time\"}")
    
    # Get end timestamp
    end_time=$(get_timestamp)
    echo -e "${YELLOW}   End Time:   $end_time${NC}"
    
    # Show response
    echo -e "${CHECK} Response: $response"
    echo
    
    # Log to file for debugging
    echo "[$start_time] Started: $description" >> ./logs/test-timestamps.log
    echo "[$end_time] Response: $response" >> ./logs/test-timestamps.log
    echo "----------------------------------------" >> ./logs/test-timestamps.log
}

# Create logs directory
mkdir -p ./logs

# Test cases with timestamps
echo -e "${BLUE}${ROCKET} RUNNING TIMESTAMPED TESTS${NC}"
echo

# TEST 1: Wins & Wrecks (Default Espresso)
test_webhook "Jose Martinez" "jose@test.com" \
    "Banking professional with 5 years experience in financial services, specializing in risk management and compliance" \
    "Jose Martinez - Wins & Wrecks Style"

# TEST 2: Tech Titan Style
test_webhook "Ilario Rossi" "ilario@tech.com" \
    "Senior Software Engineer with 8 years experience in fintech, expert in microservices architecture and cloud platforms" \
    "Ilario Rossi - Tech Titan Style"

# TEST 3: Oracle Truth Mode (MAXIMUM COFFEE!)
test_webhook "Angel Kenel" "angel@oracle.com" \
    "Veteran technology architect with 40+ years experience, from punch cards to AI automation, Swiss precision meets Canadian innovation. Currently looking for work despite being The Machine." \
    "Angel The Machine - Oracle Truth Mode"

# TEST 4: Corporate Climber
test_webhook "Sarah Executive" "sarah@corp.com" \
    "VP of Operations with 12 years experience leading teams of 50+ people. Transformed underperforming division, increased revenue by 300%, expert in change management." \
    "Sarah Executive - Corporate Climber Style"

echo -e "${WHITE}${COFFEE}=====================================================================${COFFEE}${NC}"
echo -e "${WHITE}  🎉 ${GREEN}TIMESTAMPED TESTING COMPLETE!${NC}"
echo -e "${WHITE}     Check ./logs/test-timestamps.log for debugging details${NC}"
echo -e "${WHITE}${COFFEE}=====================================================================${COFFEE}${NC}"

echo
echo -e "${BLUE}${CLOCK} Pro Tips for Debugging:${NC}"
echo -e "   • Check n8n logs: ${YELLOW}docker logs helix-mvp-n8n-1 --since=\"$start_time\"${NC}"
echo -e "   • Check ollama logs: ${YELLOW}docker logs helix-mvp-ollama-1 --since=\"$start_time\"${NC}"
echo -e "   • View test log: ${YELLOW}cat ./logs/test-timestamps.log${NC}"
echo -e "   • Real-time logs: ${YELLOW}tail -f ./logs/test-timestamps.log${NC}"
