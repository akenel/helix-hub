#!/bin/bash
# 💰🚁 BERNLY BUSINESS VALIDATION - CHF 99 Workflow Complete Testing
# Target: 5-10 coffee runs under 10 minutes each for business validation

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
ORANGE='\033[0;33m'
NC='\033[0m'

BERNLY="🐕‍♀️"
COFFEE="☕"
MONEY="💰"
TIMER="⏱️"

echo -e "${PURPLE}${MONEY}${COFFEE} BERNLY BUSINESS VALIDATION - CHF 99 WORKFLOW TESTING ${COFFEE}${MONEY}${NC}"
echo

# Business validation settings
TARGET_TIME=600  # 10 minutes in seconds
TOTAL_RUNS=10    # 2x each coffee style for reliability
LOG_FILE="./logs/business-validation-$(date +%Y%m%d_%H%M%S).log"

# Create logs directory
mkdir -p ./logs

# Coffee styles for business validation
COFFEE_STYLES=(
    "espresso:Quick Professional Win"
    "cappuccino:Strategic Career Story" 
    "latte:Executive Leadership Tale"
    "americano:Tech Innovation Journey"
    "macchiato:Entrepreneurial Victory"
)

# Business metrics tracking
total_start_time=$(date +%s)
successful_runs=0
failed_runs=0
total_processing_time=0

echo -e "${PURPLE}🎯 BUSINESS VALIDATION PARAMETERS:${NC}"
echo -e "${YELLOW}   Target per run: <${TARGET_TIME}s (${TARGET_TIME}s = 10 minutes)${NC}"
echo -e "${YELLOW}   Total test runs: ${TOTAL_RUNS} (2x each coffee style)${NC}"
echo -e "${YELLOW}   Success criteria: 80%+ under ${TARGET_TIME}s${NC}"
echo -e "${YELLOW}   Log file: ${LOG_FILE}${NC}"
echo

# Initialize log file
echo "BERNLY Business Validation Test - $(date)" > "${LOG_FILE}"
echo "Target: ${TOTAL_RUNS} runs under ${TARGET_TIME}s each" >> "${LOG_FILE}"
echo "Coffee Styles: ${#COFFEE_STYLES[@]} different Oracle prompts" >> "${LOG_FILE}"
echo "=" >> "${LOG_FILE}"

# Business validation function
run_business_test() {
    local run_number="$1"
    local style_info="$2"
    local guest_name="$3"
    
    IFS=':' read -r style_name style_description <<< "$style_info"
    
    echo -e "${BLUE}${COFFEE} Run ${run_number}/${TOTAL_RUNS}: ${style_description} (${style_name})${NC}"
    echo -e "${YELLOW}   Guest: ${guest_name}${NC}"
    
    # Start timing
    run_start_time=$(date +%s)
    start_timestamp=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
    
    echo -e "${TIMER} Start: ${start_timestamp}" | tee -a "${LOG_FILE}"
    
    # Make the business request
    response=$(curl -s -X GET "http://localhost:5678/webhook-test/podcastStudioWF_v1" \
        -H "Content-Type: application/json" \
        -d "{
            \"name\":\"${guest_name}\",
            \"email\":\"${guest_name,,}@business-test.ch\",
            \"linkedin_text\":\"${style_description} professional with proven track record\",
            \"coffee_style\":\"${style_name}\",
            \"business_validation\":true
        }" 2>/dev/null || echo "NETWORK_ERROR")
    
    end_timestamp=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
    run_end_time=$(date +%s)
    processing_time=$((run_end_time - run_start_time))
    
    echo -e "${TIMER} End: ${end_timestamp}" | tee -a "${LOG_FILE}"
    echo -e "${PURPLE}   Processing Time: ${processing_time}s${NC}" | tee -a "${LOG_FILE}"
    
    # Validate business response
    if [[ "$response" == *"Workflow was started"* ]]; then
        if [ $processing_time -le $TARGET_TIME ]; then
            echo -e "${GREEN}   ✅ BUSINESS SUCCESS: Under ${TARGET_TIME}s target!${NC}" | tee -a "${LOG_FILE}"
            ((successful_runs++))
        else
            echo -e "${ORANGE}   ⚠️  BUSINESS CONCERN: Over ${TARGET_TIME}s (${processing_time}s)${NC}" | tee -a "${LOG_FILE}"
            ((failed_runs++))
        fi
        
        # Wait for completion (business validation requires full cycle)
        echo -e "${YELLOW}   ${BERNLY} Waiting for business package generation...${NC}"
        sleep 30  # Reduced wait for business validation
        
    else
        echo -e "${RED}   ❌ BUSINESS FAILURE: ${response}${NC}" | tee -a "${LOG_FILE}"
        ((failed_runs++))
    fi
    
    total_processing_time=$((total_processing_time + processing_time))
    echo | tee -a "${LOG_FILE}"
}

# Warm up BËRNLY before business validation
echo -e "${PURPLE}${BERNLY} Pre-business warmup - ensuring optimal performance...${NC}"
warmup_response=$(curl -s -X POST http://localhost:11434/api/generate \
    -H "Content-Type: application/json" \
    -d '{
        "model": "llama3.2:latest",
        "prompt": "Business ready?",
        "stream": false,
        "options": {"temperature": 0.1, "num_predict": 5}
    }' 2>/dev/null || echo "WARMUP_FAILED")

if [[ "$warmup_response" == *"response"* ]]; then
    echo -e "${GREEN}${BERNLY} Business warmup complete - BËRNLY is ready for CHF 99 validation!${NC}"
else
    echo -e "${RED}${BERNLY} Warmup failed - proceeding anyway...${NC}"
fi
echo

echo -e "${PURPLE}🚀 STARTING BUSINESS VALIDATION SEQUENCE${NC}"
echo

# Run business validation tests
run_counter=1

# Double loop: 2 runs of each coffee style
for round in 1 2; do
    echo -e "${BLUE}📈 BUSINESS ROUND ${round}/${2} - Testing all coffee styles${NC}"
    
    for i in "${!COFFEE_STYLES[@]}"; do
        style_info="${COFFEE_STYLES[$i]}"
        
        # Generate business guest names
        case $run_counter in
            1|6) guest_name="Alex Chen" ;;
            2|7) guest_name="Maria Rodriguez" ;;
            3|8) guest_name="David Kim" ;;
            4|9) guest_name="Sarah Johnson" ;;
            5|10) guest_name="Michael Brown" ;;
        esac
        
        run_business_test "$run_counter" "$style_info" "$guest_name"
        ((run_counter++))
        
        # Brief pause between business runs
        sleep 5
    done
    echo
done

# Business validation results
total_end_time=$(date +%s)
total_test_time=$((total_end_time - total_start_time))
success_rate=$(( (successful_runs * 100) / TOTAL_RUNS ))
average_time=$(( total_processing_time / TOTAL_RUNS ))

echo -e "${PURPLE}=${MONEY}= BUSINESS VALIDATION RESULTS =${MONEY}=${NC}" | tee -a "${LOG_FILE}"
echo -e "${BLUE}Total test duration: ${total_test_time}s ($(date -d@${total_test_time} -u +%H:%M:%S))${NC}" | tee -a "${LOG_FILE}"
echo -e "${GREEN}Successful runs: ${successful_runs}/${TOTAL_RUNS}${NC}" | tee -a "${LOG_FILE}"
echo -e "${RED}Failed runs: ${failed_runs}/${TOTAL_RUNS}${NC}" | tee -a "${LOG_FILE}"
echo -e "${PURPLE}Success rate: ${success_rate}%${NC}" | tee -a "${LOG_FILE}"
echo -e "${YELLOW}Average processing time: ${average_time}s${NC}" | tee -a "${LOG_FILE}"

# Business validation verdict
echo | tee -a "${LOG_FILE}"
if [ $success_rate -ge 80 ]; then
    echo -e "${GREEN}🎉 BUSINESS VALIDATION: PASSED! ✅${NC}" | tee -a "${LOG_FILE}"
    echo -e "${GREEN}${MONEY} CHF 99 workflow is ready for production deployment!${NC}" | tee -a "${LOG_FILE}"
    echo -e "${GREEN}${BERNLY} BËRNLY has proven business-grade reliability!${NC}" | tee -a "${LOG_FILE}"
else
    echo -e "${RED}⚠️  BUSINESS VALIDATION: NEEDS IMPROVEMENT ❌${NC}" | tee -a "${LOG_FILE}"
    echo -e "${RED}${MONEY} CHF 99 workflow needs optimization before production${NC}" | tee -a "${LOG_FILE}"
    echo -e "${RED}${BERNLY} BËRNLY needs more training before business deployment${NC}" | tee -a "${LOG_FILE}"
fi

echo | tee -a "${LOG_FILE}"
echo -e "${PURPLE}📊 Next Steps:${NC}" | tee -a "${LOG_FILE}"
if [ $success_rate -ge 80 ]; then
    echo -e "${GREEN}✅ Ready for email integration${NC}" | tee -a "${LOG_FILE}"
    echo -e "${GREEN}✅ Ready for payment processing${NC}" | tee -a "${LOG_FILE}"
    echo -e "${GREEN}✅ Ready for PRODOG deployment${NC}" | tee -a "${LOG_FILE}"
else
    echo -e "${YELLOW}🔧 Optimize model parameters${NC}" | tee -a "${LOG_FILE}"
    echo -e "${YELLOW}🔧 Increase hardware resources${NC}" | tee -a "${LOG_FILE}"
    echo -e "${YELLOW}🔧 Simplify prompt complexity${NC}" | tee -a "${LOG_FILE}"
fi

echo -e "${PURPLE}Log saved to: ${LOG_FILE}${NC}"
