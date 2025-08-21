#!/bin/bash

# 🤖 Ollama Health & Capability Test Script (Enterprise Edition)
# Author: Angel & Team
# Purpose: Robust AI health check for Vault+Keycloak integration

OLLAMA_HTTP="http://localhost:11434"
OLLAMA_HTTPS="https://ollama.helix.local:8443"
DEFAULT_MODEL="tinyllama:latest"

show_help() {
cat <<EOF
Ollama Health Check Script

Usage: $0 [option]

Options:
  --help           Show this help message
  --basic          Run basic health check (default)
  --models         List available models
  --prompt         Run a prompt test
  --performance    Run performance test
  --structured     Run structured prompt test
  --all            Run all tests (recommended)
EOF
}

basic_health_check() {
    echo "🔍 1. BASIC HEALTH CHECK"
    echo "------------------------"
    if curl -s $OLLAMA_HTTP > /dev/null; then
        echo "✅ Ollama HTTP Direct Access: HEALTHY"
    else
        echo "❌ Ollama HTTP Direct Access: FAILED"
    fi

    if curl -sk $OLLAMA_HTTPS > /dev/null; then
        echo "✅ Ollama HTTPS Proxy Access: HEALTHY"
    else
        echo "❌ Ollama HTTPS Proxy Access: FAILED"
    fi
}

model_status_check() {
    echo
    echo "🧠 2. MODEL STATUS CHECK"
    echo "------------------------"
    MODELS=$(curl -s $OLLAMA_HTTP/api/tags | jq -r '.models[].name' 2>/dev/null || echo "ERROR")
    if [[ "$MODELS" != "ERROR" && -n "$MODELS" ]]; then
        echo "✅ Available Models:"
        echo "$MODELS" | sed 's/^/   📚 /'
    else
        echo "❌ Failed to retrieve models"
    fi
}

prompt_test() {
    echo
    echo "🐹 3. GUINEA PIG TEST: ANGEL'S SWISS WISDOM"
    echo "-------------------------------------------"
    PROMPT="Who is Wilhelm Tell - was he 1 in a million?"
    echo "🎯 Testing Ollama with Model: $DEFAULT_MODEL and prompt: $PROMPT"
    RAW_RESPONSE=$(curl -sk -X POST $OLLAMA_HTTP/api/generate \
        -H "Content-Type: application/json" \
        -d "{\"model\":\"$DEFAULT_MODEL\",\"prompt\":\"$PROMPT\",\"stream\":false}")
    RESPONSE=$(echo "$RAW_RESPONSE" | jq -r '.response' 2>/dev/null)
    if [ -z "$RESPONSE" ] || [ "$RESPONSE" == "null" ]; then
        echo "❌ Ollama failed to respond properly or returned unexpected format."
        echo "Raw response:"
        echo "$RAW_RESPONSE"
    else
        echo -e "\n✅ Ollama Response:"
        echo "$RESPONSE" | fold -s -w 80
    fi
}

performance_test() {
    echo
    echo "⚡ 4. PERFORMANCE ASSESSMENT"
    echo "----------------------------"
    PROMPT="Hello Angel, ready for Vault integration?"
    START_TIME=$(date +%s%N)
    PERF_RESPONSE=$(curl -s -X POST $OLLAMA_HTTP/api/generate \
        -H "Content-Type: application/json" \
        -d "{\"model\":\"$DEFAULT_MODEL\",\"prompt\":\"$PROMPT\",\"stream\":false}")
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
}

structured_test() {
    echo
    echo "🔗 5. INTEGRATION READINESS CHECK"
    echo "---------------------------------"
    STRUCT_PROMPT="Reply only with yes or no. Is integration possible?"
    echo "🎯 Testing Ollama Model $DEFAULT_MODEL with structured prompt: $STRUCT_PROMPT"
    STRUCT_RESPONSE=$(curl -s -X POST $OLLAMA_HTTP/api/generate \
        -H "Content-Type: application/json" \
        -d "{\"model\":\"$DEFAULT_MODEL\",\"prompt\":\"$STRUCT_PROMPT\",\"stream\":false}")
    RESPONSE=$(echo "$STRUCT_RESPONSE" | jq -r '.response' 2>/dev/null)
    echo "🎯 Structured Response Test:"
    echo "   📋 Request: yes/no"
    if [ -z "$RESPONSE" ] || [ "$RESPONSE" == "null" ]; then
        echo "❌ Model did not return expected output."
        echo "Raw output:"
        echo "$STRUCT_RESPONSE"
    else
        echo "   🤖 Response: $RESPONSE"
    fi
}

run_all() {
    basic_health_check
    model_status_check
    prompt_test
    performance_test
    structured_test
}

# Main logic
case "$1" in
    --help)
        show_help
        exit 0
        ;;
    --basic)
        basic_health_check
        ;;
    --models)
        model_status_check
        ;;
    --prompt)
        prompt_test
        ;;
    --performance)
        performance_test
        ;;
    --structured)
        structured_test
        ;;
    --all|"")
        run_all
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
esac