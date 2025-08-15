#!/bin/bash
# Wilhelm Tell Precision Auto-Unseal Script
# Angel's Side Cart for Vault Practice Shot

set -e

echo "🎯 Wilhelm Tell Auto-Unseal Script - Practice Shot!"
echo "================================================"

# Wait for Vault container to be ready
echo "⏳ Waiting for Vault container to be ready..."
sleep 5

# Check if Vault is responding
echo "🔍 Checking Vault health..."
for i in {1..30}; do
    if curl -s http://localhost:8200/v1/sys/health >/dev/null 2>&1; then
        echo "✅ Vault is responding!"
        break
    fi
    echo "   Attempt $i/30: Waiting for Vault..."
    sleep 2
done

# In dev mode, Vault should be auto-unsealed
echo "🔓 Checking Vault seal status..."
SEAL_STATUS=$(curl -s http://localhost:8200/v1/sys/seal-status | jq -r '.sealed')

if [ "$SEAL_STATUS" = "false" ]; then
    echo "✅ Vault is already unsealed (dev mode)!"
    
    # Set up basic auth and secrets for practice
    echo "🔧 Setting up practice secrets..."
    
    export VAULT_ADDR="http://localhost:8200"
    export VAULT_TOKEN="myroot"
    
    # Enable KV secrets engine if not already enabled
    vault secrets list | grep -q "secret/" || {
        echo "📝 Enabling KV secrets engine..."
        vault secrets enable -path=secret kv-v2
    }
    
    # Add some practice secrets
    echo "🔑 Adding practice secrets..."
    vault kv put secret/database username="helix" password="helixpass"
    vault kv put secret/app jwt_secret="dev-secret-key"
    
    echo "🎯 Practice shot successful! Vault ready for action!"
    echo "💡 Access Vault UI at: http://localhost:8200"
    echo "🔑 Root token: myroot"
    
else
    echo "❌ Vault is still sealed. Check container logs."
    exit 1
fi

echo "================================================"
echo "🏹 Wilhelm Tell precision achieved! Apple hit!"
