#!/bin/bash

# Vault Initialization Script
# Automated setup for enterprise secrets management

echo "🔐 Initializing HashiCorp Vault..."

# Wait for Vault to be ready
until vault status; do
  echo "Waiting for Vault to start..."
  sleep 2
done

# Initialize Vault
vault operator init -key-shares=5 -key-threshold=3 > /tmp/vault-init.txt

# Extract unseal keys and root token
UNSEAL_KEY_1=$(grep 'Unseal Key 1:' /tmp/vault-init.txt | cut -d' ' -f4)
UNSEAL_KEY_2=$(grep 'Unseal Key 2:' /tmp/vault-init.txt | cut -d' ' -f4)
UNSEAL_KEY_3=$(grep 'Unseal Key 3:' /tmp/vault-init.txt | cut -d' ' -f4)
ROOT_TOKEN=$(grep 'Root Token:' /tmp/vault-init.txt | cut -d' ' -f3)

# Unseal Vault
vault operator unseal $UNSEAL_KEY_1
vault operator unseal $UNSEAL_KEY_2
vault operator unseal $UNSEAL_KEY_3

# Login with root token
vault auth $ROOT_TOKEN

# Enable secrets engines
vault secrets enable -path=helix kv-v2
vault secrets enable -path=database database

# Create policies
cat > /tmp/helix-policy.hcl << EOF
path "helix/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "database/*" {
  capabilities = ["read"]
}
EOF

vault policy write helix-policy /tmp/helix-policy.hcl

# Store initial secrets
vault kv put helix/database username=helix password=banking123
vault kv put helix/sftp username=bank password=bankpassword
vault kv put helix/api-keys banking-api=helix-banking-2025

echo "✅ Vault initialization complete!"
echo "🔑 Root Token: $ROOT_TOKEN"
echo "🗄️ Secrets stored in helix/ path"
