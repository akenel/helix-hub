#!/bin/bash

# 🏔️ Helix Hub Quick Access URLs
# Created: August 16, 2025

echo "🏔️========================================🏔️"
echo "    HELIX HUB QUICK ACCESS URLS"
echo "🏔️========================================🏔️"
echo

echo "🔗 PRIMARY SERVICES:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🏦 Helix Core Banking:    https://helix.local:8443"
echo "🔑 Keycloak Admin Console: https://keycloak.helix.local:8443/admin/master/console/"
echo "🔑 Keycloak Admin API:     https://keycloak.helix.local:8443/admin/realms"
echo "🔒 Vault UI:              https://vault.helix.local:8443"
echo "⚡ n8n Workflows:         https://n8n.helix.local:8443"
echo "📁 File Manager:          https://files.helix.local:8443"
echo "🤖 Ollama AI:             https://ollama.helix.local:8443"
echo "🌐 Traefik Dashboard:     https://traefik.helix.local:8443"
echo

echo "🔗 DIRECT ACCESS (HTTP):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🏦 Helix Core:            http://localhost:5000"
echo "🔑 Keycloak:              http://localhost:8081"
echo "🔒 Vault:                 http://localhost:8200"
echo "⚡ n8n:                   http://localhost:5678"
echo "📁 FileBrowser:           http://localhost:8082"
echo "🤖 Ollama:                http://localhost:11434"
echo "🌐 Traefik:               http://localhost:8080"
echo

echo "🔑 DEFAULT CREDENTIALS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔑 Keycloak:              admin / admin123"
echo "🔒 Vault:                 Root Token: myroot"
echo "📁 FileBrowser:           admin / admin"
echo "⚡ n8n:                   admin / admin"
echo "🗄️ PostgreSQL:            helix / helixpass"
echo "📂 SFTP:                  bank / bankpassword"
echo

echo "🔧 MANAGEMENT COMMANDS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔑 Keycloak CLI:          ./scripts/keycloak-manager.sh"
echo "📊 Service Discovery:     ./scripts/service-discovery.sh"
echo "🏥 Health Check:          ./scripts/helix-health-check.sh"
echo

echo "❌ COMMON MISTAKES:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "❌ Don't use: http://keycloak.helix.local:8443/admin/ (404 error)"
echo "✅ Use instead: https://keycloak.helix.local:8443/admin/master/console/"
echo "❌ Don't use: http:// for .helix.local domains (use https://)"
echo "✅ Use http:// only for localhost:PORT direct access"
echo

echo "📝 NOTES:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "• All .helix.local domains require HTTPS (port 8443)"
echo "• Direct localhost access uses HTTP with service ports"
echo "• Modern Keycloak (v23+) requires full admin console path"
echo "• CLI management available for all services"
echo

if [[ "$1" == "--open" ]]; then
    echo "🚀 Opening services in browser..."
    
    # Check if xdg-open is available (Linux)
    if command -v xdg-open >/dev/null 2>&1; then
        xdg-open "https://helix.local:8443" 2>/dev/null &
        xdg-open "https://keycloak.helix.local:8443/admin/master/console/" 2>/dev/null &
        xdg-open "https://vault.helix.local:8443" 2>/dev/null &
        echo "✅ Opened main services in browser"
    else
        echo "ℹ️ Browser auto-open not available. Please open URLs manually."
    fi
fi

echo "🏔️ Run with --open flag to auto-open in browser"
echo "🏔️ Example: ./scripts/quick-access.sh --open"
