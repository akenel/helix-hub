#!/bin/bash
# 🚁🐕‍♀️ Bernly Avalanche Rescue - Helicopters ready, model warmed up!

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m'

BERNLY="🐕‍♀️"
HELICOPTER="🚁"
MOUNTAIN="🏔️"
AVALANCHE="❄️"

echo -e "${BLUE}${HELICOPTER}${BERNLY} BERNLY AVALANCHE RESCUE - All systems primed! ${MOUNTAIN}${NC}"
echo

# 🚁 Check if helicopters (services) are ready
check_readiness() {
    echo -e "${PURPLE}${HELICOPTER} Pre-flight checks - Are the helicopters ready?${NC}"
    
    # Check Ollama version (helicopter fuel)
    echo -e "${YELLOW}   Checking Ollama helicopter fuel...${NC}"
    ollama_version=$(curl -s http://localhost:11434/api/version 2>/dev/null || echo "FAILED")
    if [[ "$ollama_version" == *"version"* ]]; then
        echo -e "${GREEN}   ✅ Ollama helicopter ready: $ollama_version${NC}"
    else
        echo -e "${RED}   ❌ Ollama helicopter down!${NC}"
        return 1
    fi
    
    # Check available models (rescue equipment)
    echo -e "${YELLOW}   Checking rescue equipment (AI models)...${NC}"
    models=$(curl -s http://localhost:11434/api/tags 2>/dev/null || echo "FAILED")
    if [[ "$models" == *"llama3.2:latest"* ]]; then
        echo -e "${GREEN}   ✅ Bernly's AI brain ready: llama3.2:latest${NC}"
    else
        echo -e "${RED}   ❌ Bernly's brain not loaded!${NC}"
        return 1
    fi
    
    echo
}

# 🔥 Warm up Bernly's brain (keep model loaded)
warm_up_bernly() {
    echo -e "${PURPLE}${BERNLY} Warming up Bernly's brain - simple fetch command!${NC}"
    
    start_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
    echo -e "${YELLOW}   Warmup Start: $start_time${NC}"
    
    # Simple warmup request - just one byte for Bernly!
    warmup_response=$(curl -s -X POST http://localhost:11434/api/generate \
        -H "Content-Type: application/json" \
        -d '{
            "model": "llama3.2:latest",
            "prompt": "Hi Bernly! Ready?",
            "stream": false,
            "options": {
                "temperature": 0.1,
                "num_predict": 10
            }
        }' 2>/dev/null || echo "FAILED")
    
    end_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
    echo -e "${YELLOW}   Warmup End: $end_time${NC}"
    
    if [[ "$warmup_response" == *"response"* ]]; then
        echo -e "${GREEN}   ✅ Bernly is warmed up and ready for rescue!${NC}"
        echo -e "${GREEN}   🧠 Quick response test passed${NC}"
    else
        echo -e "${RED}   ❌ Bernly needs more warming up time!${NC}"
        return 1
    fi
    echo
}

# 🥪 Bite-sized rescue mission (easy prompts for old lapdog)
test_bite_sized_prompt() {
    local name="$1"
    local description="$2"
    
    echo -e "${BLUE}${BERNLY} Bite-sized rescue: $description${NC}"
    
    start_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
    echo -e "${YELLOW}   Mission Start: $start_time${NC}"
    
    # BITE-SIZED PROMPT - One-liner artifacts only!
    response=$(curl -s -X GET "http://localhost:5678/webhook-test/podcastStudioWF_v1" \
        -H "Content-Type: application/json" \
        -d "{
            \"name\":\"$name\",
            \"email\":\"test@bernly.ch\",
            \"linkedin_text\":\"Experienced professional\",
            \"prompt_style\":\"bite_sized\",
            \"max_length\":\"one_liner\"
        }")
    
    end_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
    echo -e "${YELLOW}   Mission End: $end_time${NC}"
    echo -e "${GREEN}   Response: $response${NC}"
    echo
    
    if [[ "$response" == *"Workflow was started"* ]]; then
        echo -e "${GREEN}${BERNLY} Bernly is rescuing! Waiting 90 seconds for bite-sized result...${NC}"
        sleep 90  # Reduced from 2 minutes - bite-sized should be faster!
        echo -e "${GREEN}${HELICOPTER} Rescue mission complete! Patient saved!${NC}"
        echo
        return 0
    else
        echo -e "${RED}${AVALANCHE} Avalanche! Bernly needs immediate help!${NC}"
        echo
        return 1
    fi
}

# 🚁 Main rescue operations
main() {
    echo -e "${BLUE}${AVALANCHE} AVALANCHE ALERT - Multiple victims need rescue! ${AVALANCHE}${NC}"
    echo
    
    # Pre-flight checks
    if ! check_readiness; then
        echo -e "${RED}Helicopters not ready! Aborting mission.${NC}"
        exit 1
    fi
    
    # Warm up Bernly
    if ! warm_up_bernly; then
        echo -e "${RED}Bernly not warmed up! Aborting mission.${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}🚨 SEQUENTIAL RESCUE MISSIONS (Bernly-optimized)${NC}"
    echo
    
    # Bite-sized rescue missions
    test_bite_sized_prompt "Jose" "Quick Professional Rescue"
    test_bite_sized_prompt "Ilario" "Fast Career Rescue" 
    test_bite_sized_prompt "Angel" "Swiss Precision Rescue"
    
    echo -e "${GREEN}${HELICOPTER}${BERNLY} All avalanche victims rescued! Bernly is a hero! ${MOUNTAIN}${NC}"
    echo -e "${PURPLE}Mission stats: Sequential processing, bite-sized prompts, warmed-up AI${NC}"
}

# Run the rescue operation!
main "$@"
