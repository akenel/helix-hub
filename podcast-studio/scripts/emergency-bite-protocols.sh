#!/bin/bash
# 🚨 EMERGENCY BITE-SIZED RESCUE PROTOCOLS 🚁🐕‍♀️

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "🚨 EMERGENCY BITE-SIZED PROTOCOLS - Model Stay-Alive Mode! 🚁"

# 🔥 FORCE MODEL TO STAY LOADED (Fix the auto-shutdown!)
keep_model_alive() {
    echo "🔥 Forcing model to stay alive - NO AUTO-SHUTDOWN!"
    
    # Set model to never unload (keep_alive: -1 means forever)
    curl -s -X POST http://localhost:11434/api/generate \
        -H "Content-Type: application/json" \
        -d '{
            "model": "llama3.2:latest",
            "prompt": "Stay awake Bernly!",
            "stream": false,
            "keep_alive": -1,
            "options": {
                "temperature": 0.1,
                "num_predict": 5
            }
        }' > /dev/null
    
    echo "✅ Model forced to stay loaded forever!"
}

# 🥪 MICRO BITE TEST (Tiny prompt for old lapdog)
micro_bite_test() {
    echo "🥪 Testing micro-bite (5 words max)..."
    
    start=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
    
    response=$(curl -s -X POST http://localhost:11434/api/generate \
        -H "Content-Type: application/json" \
        -d '{
            "model": "llama3.2:latest",
            "prompt": "One word: Professional",
            "stream": false,
            "keep_alive": -1,
            "options": {
                "temperature": 0.1,
                "num_predict": 1
            }
        }')
    
    end=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
    
    echo "Start: $start"
    echo "End: $end"
    echo "Response: $response"
    echo "✅ Micro-bite complete!"
}

# 🚨 MAIN EMERGENCY PROTOCOL
main() {
    echo "🚁 Implementing emergency stay-alive protocols..."
    keep_model_alive
    sleep 2
    micro_bite_test
    echo "🐕‍♀️ Bernly is now on permanent standby - model stays loaded!"
}

main "$@"
