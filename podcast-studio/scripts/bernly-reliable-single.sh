#!/bin/bash
# 🎯 BERNLY RELIABLE SINGLE - One perfect run, every time!
# No complex logic, just bulletproof basics

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🎯 BERNLY RELIABLE SINGLE - Quick Win Mode! 🐕‍♀️${NC}"
echo

# Simple health check
echo -e "${YELLOW}🏥 Quick health check...${NC}"
ollama_status=$(curl -s http://localhost:11434/api/version 2>/dev/null || echo "FAILED")
if [[ "$ollama_status" == *"version"* ]]; then
    echo -e "${GREEN}✅ Ollama ready${NC}"
else
    echo -e "${RED}❌ Ollama down - aborting${NC}"
    exit 1
fi

# Super simple warmup (tiny prompt)
echo -e "${YELLOW}🔥 Quick warmup (5 words max)...${NC}"
warmup=$(curl -s -X POST http://localhost:11434/api/generate \
    -H "Content-Type: application/json" \
    -d '{
        "model": "llama3.2:latest",
        "prompt": "Hello",
        "stream": false,
        "options": {
            "temperature": 0.1,
            "num_predict": 5
        }
    }' 2>/dev/null || echo "FAILED")

if [[ "$warmup" == *"response"* ]]; then
    echo -e "${GREEN}✅ Warmup complete${NC}"
else
    echo -e "${RED}❌ Warmup failed - aborting${NC}"
    exit 1
fi

echo

# Single reliable test with SHORT prompt and LONG timeout
echo -e "${BLUE}🚀 Single reliable run - Conservative settings${NC}"
echo -e "${YELLOW}   Guest: Simple Test Person${NC}"
echo -e "${YELLOW}   Prompt: Ultra-short for reliability${NC}"
echo -e "${YELLOW}   Timeout: Extended (15 minutes)${NC}"

start_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
echo -e "${YELLOW}   Start: $start_time${NC}"

# ULTRA-SHORT prompt (minimal processing load)
response=$(timeout 900 curl -s -X GET "http://localhost:5678/webhook-test/podcastStudioWF_v1" \
    -H "Content-Type: application/json" \
    -d '{
        "name": "Test User",
        "email": "test@simple.com",
        "linkedin_text": "Professional with experience",
        "prompt_style": "ultra_simple",
        "max_length": "very_short"
    }' 2>/dev/null || echo "TIMEOUT_OR_FAILED")

end_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%9NZ")
echo -e "${YELLOW}   End: $end_time${NC}"

# Calculate duration in seconds
start_epoch=$(date -d "$start_time" +%s 2>/dev/null || echo "0")
end_epoch=$(date -d "$end_time" +%s 2>/dev/null || echo "0")
duration=$((end_epoch - start_epoch))

echo -e "${YELLOW}   Duration: ${duration}s${NC}"
echo -e "${GREEN}   Response: $response${NC}"
echo

if [[ "$response" == *"Workflow was started"* ]]; then
    echo -e "${GREEN}🎉 RELIABLE SINGLE RUN: SUCCESS!${NC}"
    echo -e "${GREEN}   ✅ Webhook triggered successfully${NC}"
    echo -e "${GREEN}   ✅ Duration: ${duration}s${NC}"
    echo -e "${GREEN}   ✅ Next: Check n8n for completion${NC}"
    
    echo
    echo -e "${BLUE}📊 RELIABILITY METRICS:${NC}"
    echo -e "${BLUE}   Target: <900s (15 minutes)${NC}"
    echo -e "${BLUE}   Actual: ${duration}s${NC}"
    
    if [ "$duration" -lt 900 ]; then
        echo -e "${GREEN}   Status: UNDER TARGET ✅${NC}"
    else
        echo -e "${YELLOW}   Status: OVER TARGET ⚠️${NC}"
    fi
    
    exit 0
else
    echo -e "${RED}🚨 RELIABLE SINGLE RUN: FAILED${NC}"
    echo -e "${RED}   ❌ Response: $response${NC}"
    echo -e "${RED}   ❌ Duration: ${duration}s${NC}"
    echo -e "${RED}   💡 Check: n8n workflow activation${NC}"
    exit 1
fi
