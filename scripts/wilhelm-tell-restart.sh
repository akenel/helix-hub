#!/bin/bash
# 🏔️ Wilhelm Tell's Smooth Tunnel Restart Script
# For when you need that perfect Swiss precision every time
# Author: Angel & GitHub Copilot (41 years of tunnel wisdom)

echo "🏔️ Wilhelm Tell's Smooth Tunnel Restart - Swiss Precision Mode!"
echo "=============================================================="

# Step 1: Database Foundation Check
echo "🔍 Step 1: Checking Database Foundation..."
DB_EXISTS=$(docker exec helix-hub-postgres-1 psql -U helix -lqt | cut -d \| -f 1 | grep -w keycloak_db || echo "")
USER_EXISTS=$(docker exec helix-hub-postgres-1 psql -U helix -c "\du" | grep keycloak_user || echo "")

if [ -z "$DB_EXISTS" ]; then
    echo "🔧 Creating keycloak_db database..."
    docker exec helix-hub-postgres-1 psql -U helix -c "CREATE DATABASE keycloak_db;"
fi

if [ -z "$USER_EXISTS" ]; then
    echo "🔧 Creating keycloak_user..."
    docker exec helix-hub-postgres-1 psql -U helix -c "CREATE USER keycloak_user WITH ENCRYPTED PASSWORD 'keycloak_secure_pass';"
    docker exec helix-hub-postgres-1 psql -U helix -c "GRANT ALL PRIVILEGES ON DATABASE keycloak_db TO keycloak_user;"
fi

echo "✅ Database foundation ready!"

# Step 2: Clean Restart Sequence
echo "🔄 Step 2: Clean Restart Sequence..."
echo "   Stopping services gracefully..."
docker compose down keycloak >/dev/null 2>&1 || echo "   Keycloak already stopped"

echo "   Starting fresh with proper dependencies..."
docker compose up -d keycloak

# Step 3: Wait and Verify
echo "⏳ Step 3: Waiting for tunnel convergence..."
sleep 5

# Step 4: Quick Health Check
echo "🎯 Step 4: Tunnel Breakthrough Verification..."
./scripts/helix-health-check.sh | tail -10

echo ""
echo "🏹 Wilhelm Tell's Secret Applied: STAY FOCUSED!"
echo "🎯 2-Step Process: Vault secrets + Keycloak roles = Swiss precision!"
echo "🍫 Smooth as chocolate, strong as Swiss mountains!"
