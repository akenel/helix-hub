#!/bin/bash
# 🐕‍🦺 Bernly's Swiss Sanity Check Bundle
# Usage: ./scripts/bernly-sanity-check.sh

echo "🏔️ BERNLY'S SWISS SANITY CHECK STARTING..."
echo "================================================"

# Test 1: N8N Health Check
echo "🎪 Testing N8N Workflow Engine..."
curl -s -o /dev/null -w "N8N Status: %{http_code}\n" http://localhost:5678

# Test 2: Ollama AI Brain
echo "🦙 Testing Ollama AI Brain..."
curl -s -o /dev/null -w "Ollama Status: %{http_code}\n" http://localhost:11434

# Test 3: Vault Swiss Security
echo "🔐 Testing Vault Swiss Security..."
curl -s -o /dev/null -w "Vault Status: %{http_code}\n" http://localhost:8200

# Test 4: Keycloak Authentication
echo "🦁 Testing Keycloak Authentication..."
curl -s -o /dev/null -w "Keycloak Status: %{http_code}\n" http://localhost:8081

# Test 5: Eye Contact Test (Vault+Keycloak Marriage)
echo "👁️ Testing Vault+Keycloak Eye Contact Magic..."
VAULT_STATUS=$(curl -s -w "%{http_code}" -o /dev/null http://localhost:8200)
KEYCLOAK_STATUS=$(curl -s -w "%{http_code}" -o /dev/null http://localhost:8081)

if [ "$VAULT_STATUS" = "200" ] && [ "$KEYCLOAK_STATUS" = "200" ]; then
    echo "💍 Swiss Marriage Status: PERFECT HARMONY ✨"
else
    echo "⚠️ Swiss Marriage Status: Needs attention"
fi

# Test 6: Bernly's Rescue Workflow Test
echo "🚨 Testing Bernly's Emergency Response..."
RESCUE_TEST=$(curl -s -X POST http://localhost:5678/webhook/rescue-alert \
    -H "Content-Type: application/json" \
    -d '{"crisis_description":"Test emergency - need coffee in 5 minutes!"}' \
    -w "%{http_code}" -o /tmp/rescue_response.json 2>/dev/null)

if [ "$RESCUE_TEST" = "200" ]; then
    echo "🐕‍🦺 Bernly Rescue Status: READY FOR DEPLOYMENT"
    echo "📝 Response Preview:"
    head -3 /tmp/rescue_response.json 2>/dev/null | grep -o '"[^"]*"' | head -3
else
    echo "🚁 Bernly Rescue Status: Workflow needs activation (expected on first run)"
fi

echo "================================================"
echo "🎯 SWISS SANITY CHECK COMPLETE"
echo "💡 Pro Tip: The eye contact thing = enterprise harmony!"
echo "☕ Coffee Status: Earned and deserved"
