#!/bin/bash
# 🔮 THE ULTIMATE ORACLE TEST SCRIPT - One Script to Rule Them All!
# Angel + Dr. Atlas Swiss Precision Oracle Testing Framework
# "If you're not having fun, you're doing it wrong!" - Angel Kenel

set -e

# Colors for maximum coffee vibes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Oracle Power Emojis
ORACLE="🔮"
COFFEE="☕"
ROCKET="🚀"
MACHINE="🤖"
SWISS="🇨🇭"
CHECK="✅"
CROSS="❌"
CLOCK="⏰"
MONEY="💰"
CROWN="👑"

echo -e "${WHITE}${ORACLE}=====================================================================${ORACLE}${NC}"
echo -e "${WHITE}     🚀 THE ULTIMATE ORACLE TEST SCRIPT v2.0 🚀${NC}"
echo -e "${WHITE}     Angel Kenel + Dr. Atlas Swiss Precision Framework${NC}"
echo -e "${WHITE}     'Maximum Coffee Mode' - One Script to Rule Them All!${NC}"
echo -e "${WHITE}${ORACLE}=====================================================================${ORACLE}${NC}"
echo

# Configuration
N8N_WEBHOOK_URL="http://localhost:5678/webhook-test/v1"
LOG_DIR="./logs"
PROMPT_DIR="./oracle-prompts"
TIMESTAMP=$(date -u +"%Y%m%d_%H%M%S")

# Create logs directory
mkdir -p "$LOG_DIR"

# Function to get Docker-formatted timestamp
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%S.%9NZ"
}

# Function to check if n8n is running
check_n8n_health() {
    echo -e "${BLUE}${MACHINE} Step 1: Checking n8n Health${NC}"
    echo "----------------------------------------"
    
    if curl -s http://localhost:5678/healthz >/dev/null 2>&1; then
        echo -e "${CHECK} ${GREEN}n8n is running on localhost:5678${NC}"
    else
        echo -e "${CROSS} ${RED}n8n is not responding!${NC}"
        echo -e "${YELLOW}   Try: docker-compose up -d${NC}"
        exit 1
    fi
    echo
}

# Function to list available Oracle prompts
list_oracle_prompts() {
    echo -e "${BLUE}${ORACLE} Step 2: Available Oracle Prompts${NC}"
    echo "----------------------------------------"
    
    if [ -f "$PROMPT_DIR/prompt_registry.json" ]; then
        echo -e "${CHECK} ${GREEN}Oracle Prompt Registry Found${NC}"
        if command -v jq >/dev/null 2>&1; then
            echo -e "${CYAN}Available Oracle Styles:${NC}"
            jq -r '.available_prompts[] | "   \(.name) (\(.tier) tier) - \(.description)"' "$PROMPT_DIR/prompt_registry.json"
        else
            echo -e "${YELLOW}   Install jq for pretty prompt display${NC}"
        fi
    else
        echo -e "${CROSS} ${RED}Oracle Prompt Registry not found!${NC}"
        echo -e "${YELLOW}   Expected: $PROMPT_DIR/prompt_registry.json${NC}"
    fi
    echo
}

# Function to test Oracle webhook with different styles
test_oracle_style() {
    local test_name="$1"
    local name="$2"
    local email="$3" 
    local linkedin_text="$4"
    local prompt_style="$5"
    local tier="$6"
    
    echo -e "${PURPLE}${ORACLE} Testing: $test_name${NC}"
    echo -e "${CYAN}   Style: $prompt_style ($tier tier)${NC}"
    
    # Get start timestamp
    start_time=$(get_timestamp)
    echo -e "${YELLOW}   ${CLOCK} Start: $start_time${NC}"
    
    # Create test payload
    payload=$(cat <<EOF
{
    "name": "$name",
    "email": "$email", 
    "linkedin_text": "$linkedin_text",
    "prompt_style": "$prompt_style",
    "oracle_mode": true,
    "tier": "$tier",
    "test_timestamp": "$start_time",
    "test_name": "$test_name"
}
EOF
    )
    
    echo -e "${ROCKET} Invoking Oracle..."
    
    # Make the request and capture response
    if response=$(curl -s -X POST "$N8N_WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "$payload" 2>/dev/null); then
        
        # Get end timestamp
        end_time=$(get_timestamp)
        echo -e "${YELLOW}   ${CLOCK} End:   $end_time${NC}"
        echo -e "${CHECK} ${GREEN}Oracle Response: $response${NC}"
        
        # Log to file
        echo "[$start_time] ORACLE TEST: $test_name ($prompt_style)" >> "$LOG_DIR/oracle_master_log_$TIMESTAMP.log"
        echo "[$start_time] PAYLOAD: $payload" >> "$LOG_DIR/oracle_master_log_$TIMESTAMP.log"
        echo "[$end_time] RESPONSE: $response" >> "$LOG_DIR/oracle_master_log_$TIMESTAMP.log"
        echo "----------------------------------------" >> "$LOG_DIR/oracle_master_log_$TIMESTAMP.log"
        
        echo -e "${MONEY} ${GREEN}SUCCESS!${NC}"
    else
        echo -e "${CROSS} ${RED}FAILED - No response from Oracle${NC}"
        echo -e "${YELLOW}   Check n8n workflow is active${NC}"
    fi
    echo
}

# Main test execution
main() {
    echo -e "${COFFEE} ${WHITE}MAXIMUM COFFEE MODE ENGAGED!${NC}"
    echo
    
    # Health checks
    check_n8n_health
    list_oracle_prompts
    
    echo -e "${BLUE}${ROCKET} Step 3: Oracle Test Suite${NC}"
    echo "----------------------------------------"
    
    # Test 1: Wins & Wrecks (Espresso - Free Tier)
    test_oracle_style \
        "Jose Martinez - Banking Risk Manager" \
        "Jose Martinez" \
        "jose@test.com" \
        "Banking professional with 5 years experience in financial services, specializing in risk management and compliance. Started as junior analyst, promoted twice, led team through major regulatory changes. Expertise in Basel III compliance and stress testing." \
        "wins_and_wrecks" \
        "espresso"
    
    # Test 2: Corporate Climber (Cappuccino - Premium)
    test_oracle_style \
        "Sarah Executive - VP Operations" \
        "Sarah Executive" \
        "sarah@corp.com" \
        "VP of Operations with 12 years experience leading teams of 50+ people. Transformed underperforming division from $2M loss to $8M profit in 18 months. Expert in change management, strategic planning, and digital transformation. MBA from INSEAD." \
        "corporate_climber" \
        "cappuccino"
    
    # Test 3: Tech Titan (Cappuccino - Premium)
    test_oracle_style \
        "Alex Architect - Cloud Systems Expert" \
        "Alex Architect" \
        "alex@tech.com" \
        "Senior Software Architect with 15+ years building scalable systems. Led microservices transformation serving 100M+ users, reduced infrastructure costs by 60%. Expert in Kubernetes, AWS, and event-driven architecture. Passionate about AI and machine learning innovations." \
        "tech_titan" \
        "cappuccino"
    
    # Test 4: Oracle Truth (Latte - Maximum Coffee!)
    test_oracle_style \
        "Angel The Machine - Swiss Innovation Legend" \
        "Angel Kenel" \
        "angel@oracle.com" \
        "Technology veteran with 40+ years from punch cards to AI automation. Swiss precision meets Canadian innovation. Started on mainframes at Mohawk College, worked in Switzerland since college. Currently building million-dollar automation platforms while looking for work. Known as 'The Machine' for relentless execution. GmbH owner since 2015, Zero2Launch community member, InnovPark leadership program participant." \
        "oracle_truth" \
        "latte"
    
    # Summary
    echo -e "${WHITE}${ORACLE}=====================================================================${ORACLE}${NC}"
    echo -e "${WHITE}  🎉 ${GREEN}ORACLE TEST SUITE COMPLETE!${NC}"
    echo -e "${WHITE}     Master log: ${YELLOW}$LOG_DIR/oracle_master_log_$TIMESTAMP.log${NC}"
    echo -e "${WHITE}     Swiss precision achieved! ${SWISS}${NC}"
    echo -e "${WHITE}${ORACLE}=====================================================================${ORACLE}${NC}"
    
    echo
    echo -e "${BLUE}${CROWN} Debugging Commands:${NC}"
    echo -e "   • Master log: ${YELLOW}cat $LOG_DIR/oracle_master_log_$TIMESTAMP.log${NC}"
    echo -e "   • n8n logs: ${YELLOW}docker logs helix-mvp-n8n-1 --tail=50${NC}"
    echo -e "   • Ollama logs: ${YELLOW}docker logs helix-mvp-ollama-1 --tail=50${NC}"
    echo -e "   • Real-time: ${YELLOW}tail -f $LOG_DIR/oracle_master_log_$TIMESTAMP.log${NC}"
    
    echo
    echo -e "${ORACLE} ${PURPLE}Oracle Prompt Management:${NC}"
    echo -e "   • Registry: ${YELLOW}$PROMPT_DIR/prompt_registry.json${NC}"
    echo -e "   • Edit prompts: ${YELLOW}$PROMPT_DIR/*.json${NC}"
    echo -e "   • Add new style: Create new JSON file in $PROMPT_DIR${NC}"
    
    echo
    echo -e "${COFFEE} ${WHITE}The Machine + Dr. Atlas = UNSTOPPABLE!${NC} ${ROCKET}"
    echo -e "${MONEY} ${GREEN}Ready for million-dollar Oracle deployment!${NC}"
}

# Run the show
main "$@"
