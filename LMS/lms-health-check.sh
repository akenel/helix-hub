#!/bin/bash
# LMS Health Check Script ☕️🚦
# Run after successful Moodle install

set -e

echo "\n🔎 Checking Moodle Web Endpoint..."
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080 | grep 200 && echo "✅ Moodle is up!" || echo "❌ Moodle not responding."

echo "\n🔎 Checking Traefik Dashboard..."
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8081/dashboard/ | grep 200 && echo "✅ Traefik dashboard is up!" || echo "❌ Traefik dashboard not responding."

echo "\n🔎 Testing Postgres DB connectivity from Moodle container..."
docker compose exec moodle bash -c "psql -h postgres-moodle -U moodleuser -d moodle -c '\l'" && echo "✅ Moodle can connect to Postgres!" || echo "❌ DB connection failed."

echo "\n🔎 Listing running containers..."
docker compose ps

echo "\n🔎 Showing last 20 Moodle logs..."
docker compose logs moodle --tail 20

echo "\n🏁 Health check complete!"
