#!/bin/bash
# 🔮 JobTalks Oracle Test Script - podcastStudioWF_v0-0-2
# Angel + Dr. Atlas Oracle prompt testing with Swiss precision!

set -e

# Colors for beautiful output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Oracle emojis
ORACLE="🔮"
COFFEE="☕"
ROCKET="🚀"
CLOCK="⏰"
CHECK="✅"
MACHINE="🤖"

echo -e "${WHITE}${ORACLE}=====================================================================${ORACLE}${NC}"
echo -e "${WHITE}     JOBTALKS ORACLE TEST - podcastStudioWF_v0-0-2${NC}"
echo -e "${WHITE}     Maximum Coffee Mode + Swiss Precision + Oracle Truth${NC}"
echo -e "${WHITE}${ORACLE}=====================================================================${ORACLE}${NC}"
echo

# Function to get Docker-formatted timestamp
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%S.%9NZ"
}

# Function to test Oracle webhook with different prompts
test_oracle_webhook() {
    local name="$1"
    local email="$2"
    local linkedin_text="$3"
    local prompt_style="$4"
    local description="$5"
    
    echo -e "${BLUE}${ORACLE} Testing Oracle: $description${NC}"
    
    # Get start timestamp
    start_time=$(get_timestamp)
    echo -e "${YELLOW}   Start Time: $start_time${NC}"
    
    # Make the Oracle request
    echo -e "${ROCKET} Invoking Oracle with prompt style: $prompt_style..."
    response=$(curl -s -X POST http://localhost:5678/webhook-test/v1 \
        -H "Content-Type: application/json" \
        -d "{
            \"name\":\"$name\",
            \"email\":\"$email\",
            \"linkedin_text\":\"$linkedin_text\",
            \"prompt_style\":\"$prompt_style\",
            \"oracle_mode\":true,
            \"test_timestamp\":\"$start_time\"
        }")
    
    # Get end timestamp
    end_time=$(get_timestamp)
    echo -e "${YELLOW}   End Time:   $end_time${NC}"
    
    # Show response
    echo -e "${CHECK} Oracle Response: $response"
    echo
    
    # Log to file for debugging
    mkdir -p ./logs
    echo "[$start_time] Oracle Started: $description ($prompt_style)" >> ./logs/oracle-test-timestamps.log
    echo "[$end_time] Oracle Response: $response" >> ./logs/oracle-test-timestamps.log
    echo "----------------------------------------" >> ./logs/oracle-test-timestamps.log
}

echo -e "${BLUE}${MACHINE} ORACLE PROMPT SYSTEM TESTS${NC}"
echo

# Test different Oracle prompt styles
echo -e "${PURPLE}Test 1: Wins & Wrecks (Espresso Tier)${NC}"
test_oracle_webhook "Jose Martinez" "jose@test.com" \
    "Banking professional with 5 years experience in financial services, specializing in risk management and compliance. Started as junior analyst, promoted twice, led team through major regulatory changes." \
    "wins_and_wrecks" \
    "Jose Martinez - Wins & Wrecks Style"

echo -e "${PURPLE}Test 2: Corporate Climber (Cappuccino Tier)${NC}" 
test_oracle_webhook "Sarah Executive" "sarah@corp.com" \
    "VP of Operations with 12 years experience leading teams of 50+ people. Transformed underperforming division, increased revenue by 300%, expert in change management and strategic planning." \
    "corporate_climber" \
    "Sarah Executive - Corporate Climber Style"

echo -e "${PURPLE}Test 3: Tech Titan (Cappuccino Tier)${NC}"
test_oracle_webhook "Alex Architect" "alex@tech.com" \
    "Senior Software Architect with 15+ years building scalable systems. Led microservices transformation, expert in cloud architecture, passionate about AI and machine learning innovations." \
    "tech_titan" \
    "Alex Architect - Tech Titan Style"

echo -e "${PURPLE}Test 4: Oracle Truth (Latte Tier - MAXIMUM COFFEE!)${NC}"
test_oracle_webhook "Angel Kenel" "angel@oracle.com" \
    "Technology veteran with 40+ years from punch cards to AI automation. Swiss precision meets Canadian innovation. Currently building million-dollar automation platforms while looking for work. The Machine." \
    "oracle_truth" \
    "Angel The Machine - Oracle Truth Mode"

echo -e "${WHITE}${ORACLE}=====================================================================${ORACLE}${NC}"
echo -e "${WHITE}  🎉 ${GREEN}ORACLE TESTING COMPLETE!${NC}"
echo -e "${WHITE}     JobTalks Oracle v0-0-2 ready for world domination! ${COFFEE}${NC}"
echo -e "${WHITE}${ORACLE}=====================================================================${ORACLE}${NC}"

echo
echo -e "${BLUE}${CLOCK} Oracle Debugging Commands:${NC}"
echo -e "   • Check n8n logs: ${YELLOW}docker logs helix-mvp-n8n-1 --since=\"$start_time\"${NC}"
echo -e "   • Check ollama logs: ${YELLOW}docker logs helix-mvp-ollama-1 --since=\"$start_time\"${NC}"
echo -e "   • View oracle log: ${YELLOW}cat ./logs/oracle-test-timestamps.log${NC}"
echo -e "   • Real-time oracle: ${YELLOW}tail -f ./logs/oracle-test-timestamps.log${NC}"

echo
echo -e "${ORACLE} ${PURPLE}Oracle Prompt Files:${NC}"
echo -e "   • Wins & Wrecks: ${YELLOW}./oracle-prompts/wins_and_wrecks.json${NC}"
echo -e "   • Corporate Climber: ${YELLOW}./oracle-prompts/corporate_climber.json${NC}"
echo -e "   • Tech Titan: ${YELLOW}./oracle-prompts/tech_titan.json${NC}"
echo -e "   • Oracle Truth: ${YELLOW}./oracle-prompts/oracle_truth.json${NC}"
echo -e "   • Prompt Registry: ${YELLOW}./oracle-prompts/prompt_registry.json${NC}"

echo
echo -e "${COFFEE} ${WHITE}MAXIMUM COFFEE ACHIEVED! Ready for Oracle deployment!${NC} ${ROCKET}"
