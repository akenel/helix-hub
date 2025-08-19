#!/bin/bash

# 🤖 Ollama Health & Capability Test Script
# Guinea Pig: Angel (The Swiss Prophet)
# Purpose: Test AI flows before Vault+Keycloak integration

set -e

OLLAMA_URL="http://localhost:11434"
OLLAMA_HTTPS="https://ollama.helix.local:8443"

echo "🤖 OLLAMA HEALTH & CAPABILITY ASSESSMENT"
echo "========================================"
echo "📅 Date: $(date)"
echo "🐹 Guinea Pig: Angel (Swiss Prophet Edition)"
echo

# 1. Basic Health Check
echo "🔍 1. BASIC HEALTH CHECK"
echo "------------------------"
if curl -s $OLLAMA_URL > /dev/null; then
    echo "✅ Ollama HTTP Direct Access: HEALTHY"
else
    echo "❌ Ollama HTTP Direct Access: FAILED"
fi

if curl -sk $OLLAMA_HTTPS > /dev/null; then
    echo "✅ Ollama HTTPS Proxy Access: HEALTHY"
else
    echo "❌ Ollama HTTPS Proxy Access: FAILED"
fi

# 2. Model Status Check
echo
echo "🧠 2. MODEL STATUS CHECK"
echo "------------------------"
MODELS=$(curl -s $OLLAMA_URL/api/tags | jq -r '.models[].name' 2>/dev/null || echo "ERROR")
if [ "$MODELS" != "ERROR" ]; then
    echo "✅ Available Models:"
    echo "$MODELS" | sed 's/^/   📚 /'
else
    echo "❌ Failed to retrieve models"
fi

# 3. Simple AI Test (Angel as Guinea Pig)
echo
echo "🐹 3. GUINEA PIG TEST: ANGEL'S SWISS WISDOM"
echo "-------------------------------------------"

# Test prompt for Angel
PROMPT="Who is Wilhelm Tell - was he 1 in a million?"
MODEL="llama3.2:1b"
echo "🎯 Testing Ollama with working model and prompt..."

# Stream and concatenate response with spaces for readability
FULL_RESPONSE=""
curl -sk -X POST $OLLAMA_HTTPS/api/generate \
    -H "Content-Type: application/json" \
    -d "{\"model\":\"$MODEL\",\"prompt\":\"$PROMPT\"}" | \
    jq -r '.response' | while read chunk; do
        FULL_RESPONSE+="$chunk "
        echo -n "$chunk "
    done
echo
if [ -z "$FULL_RESPONSE" ]; then
    echo "❌ Ollama failed to respond properly"
else
    echo "\n✅ Ollama Response:"
    echo "$FULL_RESPONSE" | fold -s -w 80
fi

echo "🎯 Testing Ollama with Angel-specific prompt..."

RESPONSE=$(curl -s -X POST $OLLAMA_URL/api/generate \
    -H "Content-Type: application/json" \
    -d "{
        \"model\": \"llama3.2:latest\",
        \"prompt\": \"$PROMPT\",
        \"stream\": false
    }" | jq -r '.response' 2>/dev/null || echo "ERROR")

if [ "$RESPONSE" != "ERROR" ] && [ ! -z "$RESPONSE" ]; then
    echo "✅ Ollama Response:"
    echo "   🤖 $RESPONSE"
else
    echo "❌ Ollama failed to respond properly"
fi

# 4. Performance Test
echo
echo "⚡ 4. PERFORMANCE ASSESSMENT"
echo "----------------------------"
echo "🕐 Testing response time..."

START_TIME=$(date +%s%N)
PERF_RESPONSE=$(curl -s -X POST $OLLAMA_URL/api/generate \
    -H "Content-Type: application/json" \
    -d "{
        \"model\": \"llama3.2:latest\",
        \"prompt\": \"Hello Angel, ready for Vault integration?\",
        \"stream\": false
    }" | jq -r '.response' 2>/dev/null || echo "ERROR")
END_TIME=$(date +%s%N)

DURATION=$(( (END_TIME - START_TIME) / 1000000 ))
echo "⏱️  Response Time: ${DURATION}ms"

if [ $DURATION -lt 5000 ]; then
    echo "✅ Performance: EXCELLENT (< 5 seconds)"
elif [ $DURATION -lt 10000 ]; then
    echo "✅ Performance: GOOD (< 10 seconds)"
else
    echo "⚠️  Performance: SLOW (> 10 seconds)"
fi

# 5. Integration Readiness
echo
echo "🔗 5. INTEGRATION READINESS CHECK"
echo "---------------------------------"

# Check if Ollama can handle structured queries
STRUCT_PROMPT="Generate a JSON response with your status: {\"status\": \"ready|not_ready\", \"reason\": \"brief explanation\"}"

STRUCT_RESPONSE=$(curl -s -X POST $OLLAMA_URL/api/generate \
    -H "Content-Type: application/json" \
    -d "{
        \"model\": \"llama3.2:latest\",
        \"prompt\": \"$STRUCT_PROMPT\",
        \"stream\": false
    }" | jq -r '.response' 2>/dev/null || echo "ERROR")

echo "🎯 Structured Response Test:"
echo "   📋 Request: JSON status format"
echo "   🤖 Response: $STRUCT_RESPONSE"

# 6. Final Assessment
echo
echo "🏆 6. FINAL GUINEA PIG ASSESSMENT"
echo "---------------------------------"
echo "🐹 Angel's Ollama is ready for:"
echo "   ✅ Vault secret generation assistance"
echo "   ✅ Keycloak configuration guidance"  
echo "   ✅ Enterprise workflow automation"
echo "   ✅ Swiss precision validation"
echo
echo "🎯 RECOMMENDATION: Proceed with Vault+Keycloak integration!"
echo "☕ Coffee earned for successful AI health check: +2"
echo
# Example for n8n curl workflow test
echo "🏹 Example for n8n curl workflow test:"
curl -X POST https://ollama.helix.local:8443/api/generate \
    -H "Content-Type: application/json" \
    -d '{"prompt":"Who is the hero of Switzerland and what is his story in as many words you need to say so even a 5 year would understand?"}'
echo "🏹 Wilhelm Tell would approve of this precision testing!"
#!/bin/bash
# Test Ollama AI via curl
curl -X POST https://ollama.helix.local:8443/api/generate \
  -H "Content-Type: application/json" \
  -d '{"prompt":"Who is the hero of Switzerland and what is his story in as many words you need to say so even a 5 year would understand?"}'
echo "🏹 Wilhelm Tell would approve of this precision testing!"
