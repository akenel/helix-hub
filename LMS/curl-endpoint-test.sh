#!/bin/bash
# LMS Curl Endpoint Test Script 🏔️
# Run this to test key endpoints and AI workflows after deploy

set -e

# Test Moodle Web Endpoint
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8083 | grep 200 && echo "✅ Moodle (8083) is up!" || echo "❌ Moodle not responding on 8083."

# Test Traefik Dashboard
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8081/dashboard/ | grep 200 && echo "✅ Traefik dashboard is up!" || echo "❌ Traefik dashboard not responding."

# Test n8n Workflow
curl -sk -X POST https://n8n.helix.local:8443/webhook/PROD_n8n-base-sanity-check -H "Content-Type: application/json" -d '{"test":"sanity"}' | jq .

# Test Ollama AI Endpoint
curl -sk -X POST https://ollama.helix.local:8443/api/generate -H "Content-Type: application/json" -d '{"model":"llama3.2:1b","prompt":"Who is Wilhelm Tell - was he 1 in a million?"}' | jq -r '.response // .error // "No response"' | tr -d '\n' | fold -s -w 80

# List running containers

docker compose ps

echo "\n🏁 Curl endpoint test complete!"
