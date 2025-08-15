#!/bin/bash
# Wilhelm Tell Vault Health Check - Goat Milk Edition
# Eagle Eye Shot with Key Status (First 12 Numbers Masked)

echo "🐐 Wilhelm Tell Vault Health - Goat Milk Practice Shot!"
echo "======================================================="

# Vault Status Check
echo "🗝️ Checking Vault Key Status..."
VAULT_STATUS=$(curl -s http://localhost:8200/v1/sys/health)

if [ $? -eq 0 ]; then
    echo "✅ Vault Responding!"
    
    # Extract key status with first 12 digits masked
    SEALED=$(echo "$VAULT_STATUS" | jq -r '.sealed')
    INITIALIZED=$(echo "$VAULT_STATUS" | jq -r '.initialized')
    VERSION=$(echo "$VAULT_STATUS" | jq -r '.version')
    CLUSTER_ID=$(echo "$VAULT_STATUS" | jq -r '.cluster_id' | sed 's/^.\{12\}/************/')
    
    echo "🔐 Sealed Status: $SEALED"
    echo "🚀 Initialized: $INITIALIZED" 
    echo "📦 Version: $VERSION"
    echo "🏔️ Cluster ID: $CLUSTER_ID"
    
    if [ "$SEALED" = "false" ]; then
        echo "🎯 VAULT DOOR OPEN - Ready for Keycloak tunnel breakthrough!"
        echo "☕ Wilhelm Tell precision achieved with goat milk power!"
    else
        echo "🔒 Vault sealed - Need the key maker!"
    fi
else
    echo "❌ Vault not responding - Check the goats!"
fi

echo "======================================================="
echo "🏹 Eagle eye shot complete - The 9 lives on!"
