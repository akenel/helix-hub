#!/bin/bash

# 🏔️ Helix Hub Master Control Panel
# Swiss-Precision Script Management System
# Created: August 16, 2025

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."  # Move to project root

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Check if whiptail is installed
if ! command -v whiptail &> /dev/null; then
    echo -e "${RED}ERROR: whiptail is not installed!${NC}"
    echo "Install it with: sudo apt-get install whiptail"
    exit 1
fi

# Function to show title
show_title() {
    whiptail --title "🏔️ Helix Hub Control Panel" --msgbox "Welcome to the Swiss-Precision Management System\n\nManage all your Helix Hub services, health checks, and maintenance tasks from this central control panel.\n\nBuilt with Swiss Engineering Excellence 🇨🇭" 12 70
}

# Function to run a script and show results
run_script() {
    local script_path="$1"
    local script_name="$2"
    local description="$3"
    
    if [[ ! -f "$script_path" ]]; then
        whiptail --title "❌ Script Not Found" --msgbox "Script not found: $script_path\n\nPlease check if the file exists and is executable." 10 60
        return 1
    fi
    
    # Make sure script is executable
    chmod +x "$script_path"
    
    # Show what we're about to run
    if whiptail --title "🚀 Execute Script" --yesno "About to run: $script_name\n\nDescription: $description\n\nContinue?" 10 60; then
        # Clear screen and run script
        clear
        echo -e "${CYAN}🏔️ Executing: $script_name${NC}"
        echo -e "${YELLOW}Description: $description${NC}"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo
        
        # Run the script
        bash "$script_path"
        local exit_code=$?
        
        echo
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        if [[ $exit_code -eq 0 ]]; then
            echo -e "${GREEN}✅ Script completed successfully!${NC}"
        else
            echo -e "${RED}❌ Script completed with errors (exit code: $exit_code)${NC}"
        fi
        echo
        read -p "Press Enter to continue..."
    fi
}

# Function to show system status
show_system_status() {
    local status_output=$(mktemp)
    
    {
        echo "🏔️ HELIX HUB SYSTEM STATUS"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo
        echo "📊 Container Status:"
        docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep helix-hub || echo "No containers running"
        echo
        echo "💾 System Resources:"
        echo "Memory: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
        echo "Disk: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 " used)"}')"
        echo
        echo "🌐 Network Connectivity:"
        if curl -s --connect-timeout 5 http://localhost:5000 >/dev/null; then
            echo "✅ Helix Core: Online"
        else
            echo "❌ Helix Core: Offline"
        fi
        
        if curl -s --connect-timeout 5 http://localhost:8081 >/dev/null; then
            echo "✅ Keycloak: Online"
        else
            echo "❌ Keycloak: Offline"
        fi
        
        if curl -s --connect-timeout 5 http://localhost:8200 >/dev/null; then
            echo "✅ Vault: Online"
        else
            echo "❌ Vault: Offline"
        fi
        
    } > "$status_output"
    
    whiptail --title "🏔️ System Status" --textbox "$status_output" 20 80
    rm "$status_output"
}

# Function to show logs for a service
show_service_logs() {
    local services=()
    local containers
    
    # Get list of helix-hub containers
    readarray -t containers < <(docker ps --format "{{.Names}}" | grep helix-hub | sort)
    
    if [[ ${#containers[@]} -eq 0 ]]; then
        whiptail --title "❌ No Containers" --msgbox "No Helix Hub containers are currently running." 8 50
        return
    fi
    
    # Build menu options
    local i=1
    for container in "${containers[@]}"; do
        services+=("$i" "${container}")
        ((i++))
    done
    
    local choice
    choice=$(whiptail --title "📋 Container Logs" --menu "Select a container to view logs:" 15 60 8 "${services[@]}" 3>&1 1>&2 2>&3)
    
    if [[ -n "$choice" ]]; then
        local selected_container="${containers[$((choice-1))]}"
        local log_output=$(mktemp)
        
        echo "📋 Last 50 lines from $selected_container:" > "$log_output"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> "$log_output"
        docker logs --tail 50 "$selected_container" >> "$log_output" 2>&1
        
        whiptail --title "📋 Logs: $selected_container" --textbox "$log_output" 20 100
        rm "$log_output"
    fi
}

# Main menu function
show_main_menu() {
    while true; do
        local choice
        choice=$(whiptail --title "🏔️ Helix Hub Control Panel" --menu "Swiss-Precision Management System\nChoose an option:" 20 80 12 \
            "1" "🚀 Service Management" \
            "2" "🏥 Health & Monitoring" \
            "3" "🔐 Security & Authentication" \
            "4" "🛠️ Maintenance & Utilities" \
            "5" "📋 System Information" \
            "6" "🎪 Demo & Testing" \
            "7" "📊 View Container Logs" \
            "8" "💻 System Status" \
            "9" "📚 Documentation" \
            "0" "❌ Exit" \
            3>&1 1>&2 2>&3)
        
        case $choice in
            1) show_service_menu ;;
            2) show_health_menu ;;
            3) show_security_menu ;;
            4) show_maintenance_menu ;;
            5) show_info_menu ;;
            6) show_demo_menu ;;
            7) show_service_logs ;;
            8) show_system_status ;;
            9) show_documentation ;;
            0) break ;;
            *) 
                if [[ -z "$choice" ]]; then
                    break
                fi
                ;;
        esac
    done
}

# Service Management Menu
show_service_menu() {
    local choice
    choice=$(whiptail --title "🚀 Service Management" --menu "Manage Helix Hub Services:" 15 70 8 \
        "1" "📊 Service Discovery (Full Report)" \
        "2" "🔗 Quick Access URLs" \
        "3" "🐳 Start All Services" \
        "4" "🛑 Stop All Services" \
        "5" "🔄 Restart All Services" \
        "6" "🏗️ Rebuild Services" \
        "0" "🔙 Back to Main Menu" \
        3>&1 1>&2 2>&3)
    
    case $choice in
        1) run_script "./scripts/service-discovery.sh" "Service Discovery" "Complete service status and URL report" ;;
        2) run_script "./scripts/quick-access.sh" "Quick Access URLs" "Show all service URLs and credentials" ;;
        3) 
            if whiptail --title "🐳 Start Services" --yesno "Start all Helix Hub services using Docker Compose?" 8 50; then
                clear
                echo -e "${GREEN}🚀 Starting all services...${NC}"
                docker-compose up -d
                read -p "Press Enter to continue..."
            fi
            ;;
        4)
            if whiptail --title "🛑 Stop Services" --yesno "Stop all Helix Hub services?\n\nThis will shut down all containers." 10 50; then
                clear
                echo -e "${YELLOW}🛑 Stopping all services...${NC}"
                docker-compose down
                read -p "Press Enter to continue..."
            fi
            ;;
        5)
            if whiptail --title "🔄 Restart Services" --yesno "Restart all Helix Hub services?" 8 50; then
                clear
                echo -e "${BLUE}🔄 Restarting all services...${NC}"
                docker-compose restart
                read -p "Press Enter to continue..."
            fi
            ;;
        6)
            if whiptail --title "🏗️ Rebuild Services" --yesno "Rebuild and restart all services?\n\nThis will rebuild Docker images and may take several minutes." 10 60; then
                clear
                echo -e "${PURPLE}🏗️ Rebuilding all services...${NC}"
                docker-compose down
                docker-compose up --build -d
                read -p "Press Enter to continue..."
            fi
            ;;
    esac
}

# Health & Monitoring Menu
show_health_menu() {
    local choice
    choice=$(whiptail --title "🏥 Health & Monitoring" --menu "Health Checks and Monitoring:" 15 70 8 \
        "1" "🏥 Full System Health Check" \
        "2" "🤖 Ollama AI Health Check" \
        "3" "🔍 Sanity Check (Quick)" \
        "4" "📊 Resource Usage" \
        "5" "🌐 Network Connectivity Test" \
        "6" "🔧 Swiss Grand Tour (Comprehensive)" \
        "0" "🔙 Back to Main Menu" \
        3>&1 1>&2 2>&3)
    
    case $choice in
        1) run_script "./scripts/helix-health-check.sh" "Full Health Check" "Comprehensive system health validation" ;;
        2) run_script "./scripts/ollama-health-check.sh" "Ollama Health Check" "AI service health and model validation" ;;
        3) run_script "./scripts/bernly-sanity-check.sh" "Sanity Check" "Quick system validation" ;;
        4) 
            clear
            echo -e "${CYAN}📊 System Resource Usage${NC}"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo
            docker stats --no-stream
            echo
            echo "System Memory:"
            free -h
            echo
            echo "Disk Usage:"
            df -h
            read -p "Press Enter to continue..."
            ;;
        5)
            clear
            echo -e "${CYAN}🌐 Network Connectivity Test${NC}"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo
            for service in "localhost:5000" "localhost:8081" "localhost:8200" "localhost:5678" "localhost:8082"; do
                if curl -s --connect-timeout 5 "http://$service" >/dev/null; then
                    echo -e "✅ $service: ${GREEN}Online${NC}"
                else
                    echo -e "❌ $service: ${RED}Offline${NC}"
                fi
            done
            echo
            read -p "Press Enter to continue..."
            ;;
        6) run_script "./scripts/swiss-grand-tour.sh" "Swiss Grand Tour" "Comprehensive system tour and validation" ;;
    esac
}

# Security & Authentication Menu
show_security_menu() {
    local choice
    choice=$(whiptail --title "🔐 Security & Authentication" --menu "Security and Authentication Tools:" 15 70 8 \
        "1" "🔑 Keycloak Management (Interactive)" \
        "2" "👥 List Keycloak Users" \
        "3" "🏦 Create Banking User" \
        "4" "🔒 Vault Operations" \
        "5" "🔄 Reset Keycloak Admin Password" \
        "6" "🔐 Security Audit" \
        "0" "🔙 Back to Main Menu" \
        3>&1 1>&2 2>&3)
    
    case $choice in
        1) run_script "./scripts/keycloak-manager.sh" "Keycloak Manager" "Interactive Keycloak user and role management" ;;
        2) 
            clear
            echo -e "${CYAN}👥 Keycloak Users${NC}"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            ./scripts/keycloak-manager.sh list-users
            read -p "Press Enter to continue..."
            ;;
        3)
            clear
            echo -e "${CYAN}🏦 Creating Banking User${NC}"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            ./scripts/keycloak-manager.sh create-banking-user
            read -p "Press Enter to continue..."
            ;;
        4)
            whiptail --title "🔒 Vault Operations" --msgbox "Vault management features coming soon!\n\nCurrent access:\n- Web UI: http://localhost:8200\n- Token: myroot" 10 50
            ;;
        5)
            if whiptail --title "🔄 Reset Password" --yesno "Reset Keycloak admin password to 'admin123'?" 8 50; then
                clear
                echo -e "${YELLOW}🔄 Resetting Keycloak admin password...${NC}"
                ./scripts/keycloak-manager.sh reset-admin-password
                read -p "Press Enter to continue..."
            fi
            ;;
        6)
            whiptail --title "🔐 Security Audit" --msgbox "Security audit features coming soon!\n\nThis will check:\n- Password policies\n- SSL certificates\n- Access controls\n- Audit logs" 12 50
            ;;
    esac
}

# Maintenance & Utilities Menu
show_maintenance_menu() {
    local choice
    choice=$(whiptail --title "🛠️ Maintenance & Utilities" --menu "System Maintenance Tools:" 15 70 8 \
        "1" "🧹 Swiss Cleanup (System Clean)" \
        "2" "🔄 Wilhelm Tell Restart" \
        "3" "🚀 Git Operations (Super Sonic)" \
        "4" "🐳 Docker System Cleanup" \
        "5" "📁 Clean Temporary Files" \
        "6" "💾 Backup Configuration" \
        "0" "🔙 Back to Main Menu" \
        3>&1 1>&2 2>&3)
    
    case $choice in
        1) run_script "./scripts/swiss-cleanup.sh" "Swiss Cleanup" "Clean temporary files and system maintenance" ;;
        2) run_script "./scripts/wilhelm-tell-restart.sh" "Wilhelm Tell Restart" "Swiss-style system restart procedure" ;;
        3) run_script "./scripts/super-sonic-git-confirmation.sh" "Git Operations" "High-speed Git operations and confirmations" ;;
        4)
            if whiptail --title "🐳 Docker Cleanup" --yesno "Clean Docker system (remove unused containers, networks, images)?\n\nThis will free up disk space." 10 60; then
                clear
                echo -e "${YELLOW}🧹 Cleaning Docker system...${NC}"
                docker system prune -f
                docker volume prune -f
                echo -e "${GREEN}✅ Docker cleanup completed!${NC}"
                read -p "Press Enter to continue..."
            fi
            ;;
        5)
            clear
            echo -e "${YELLOW}📁 Cleaning temporary files...${NC}"
            find . -name "*.tmp" -delete 2>/dev/null || true
            find . -name "*.log" -mtime +7 -delete 2>/dev/null || true
            find . -name "*~" -delete 2>/dev/null || true
            echo -e "${GREEN}✅ Temporary files cleaned!${NC}"
            read -p "Press Enter to continue..."
            ;;
        6)
            whiptail --title "💾 Backup" --msgbox "Configuration backup features coming soon!\n\nThis will backup:\n- Docker compose files\n- Configuration files\n- SSL certificates\n- Database schemas" 12 50
            ;;
    esac
}

# System Information Menu
show_info_menu() {
    local choice
    choice=$(whiptail --title "📋 System Information" --menu "System Information and Documentation:" 15 70 8 \
        "1" "🐳 Docker Information" \
        "2" "🌐 Network Configuration" \
        "3" "📊 Performance Metrics" \
        "4" "📁 File System Usage" \
        "5" "🔍 Process Information" \
        "6" "🏔️ Helix Hub Version Info" \
        "0" "🔙 Back to Main Menu" \
        3>&1 1>&2 2>&3)
    
    case $choice in
        1)
            local docker_info=$(mktemp)
            echo "🐳 Docker System Information" > "$docker_info"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> "$docker_info"
            docker version >> "$docker_info" 2>&1
            echo "" >> "$docker_info"
            echo "Docker Compose Version:" >> "$docker_info"
            docker-compose version >> "$docker_info" 2>&1
            whiptail --title "🐳 Docker Info" --textbox "$docker_info" 20 80
            rm "$docker_info"
            ;;
        2)
            local network_info=$(mktemp)
            echo "🌐 Network Configuration" > "$network_info"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> "$network_info"
            echo "Docker Networks:" >> "$network_info"
            docker network ls >> "$network_info"
            echo "" >> "$network_info"
            echo "Host Network Interfaces:" >> "$network_info"
            ip addr show | grep -E "(inet |^\d+:)" >> "$network_info"
            whiptail --title "🌐 Network Info" --textbox "$network_info" 20 80
            rm "$network_info"
            ;;
        3)
            local perf_info=$(mktemp)
            echo "📊 Performance Metrics" > "$perf_info"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> "$perf_info"
            echo "System Load:" >> "$perf_info"
            uptime >> "$perf_info"
            echo "" >> "$perf_info"
            echo "Memory Usage:" >> "$perf_info"
            free -h >> "$perf_info"
            echo "" >> "$perf_info"
            echo "CPU Information:" >> "$perf_info"
            lscpu | head -10 >> "$perf_info"
            whiptail --title "📊 Performance" --textbox "$perf_info" 20 80
            rm "$perf_info"
            ;;
        4)
            local fs_info=$(mktemp)
            echo "📁 File System Usage" > "$fs_info"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> "$fs_info"
            df -h >> "$fs_info"
            echo "" >> "$fs_info"
            echo "Docker Space Usage:" >> "$fs_info"
            docker system df >> "$fs_info" 2>&1
            whiptail --title "📁 File System" --textbox "$fs_info" 20 80
            rm "$fs_info"
            ;;
        5)
            local proc_info=$(mktemp)
            echo "🔍 Process Information" > "$proc_info"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> "$proc_info"
            echo "Top Processes:" >> "$proc_info"
            ps aux --sort=-%cpu | head -10 >> "$proc_info"
            echo "" >> "$proc_info"
            echo "Docker Containers:" >> "$proc_info"
            docker ps --format "table {{.Names}}\t{{.Status}}\t{{.CPU}}\t{{.MemUsage}}" >> "$proc_info" 2>&1
            whiptail --title "🔍 Processes" --textbox "$proc_info" 20 80
            rm "$proc_info"
            ;;
        6)
            local version_info=$(mktemp)
            echo "🏔️ Helix Hub Version Information" > "$version_info"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> "$version_info"
            echo "Project: Helix Hub Banking Platform" >> "$version_info"
            echo "Version: 1.0.0-dev" >> "$version_info"
            echo "Built: $(date)" >> "$version_info"
            echo "Location: $(pwd)" >> "$version_info"
            echo "" >> "$version_info"
            echo "Service Versions:" >> "$version_info"
            echo "- Keycloak: 23.0.1" >> "$version_info"
            echo "- Vault: 1.15.2" >> "$version_info"
            echo "- PostgreSQL: 14-alpine" >> "$version_info"
            echo "- Traefik: v2.10" >> "$version_info"
            echo "- n8n: 1.19.4" >> "$version_info"
            whiptail --title "🏔️ Version Info" --textbox "$version_info" 15 60
            rm "$version_info"
            ;;
    esac
}

# Demo & Testing Menu
show_demo_menu() {
    local choice
    choice=$(whiptail --title "🎪 Demo & Testing" --menu "Demo Scripts and Testing Tools:" 15 70 8 \
        "1" "🎯 Sally Proof Live Demo" \
        "2" "⚡ Sally Avalanche Ultimate Proof" \
        "3" "🧪 Custom Test Suite" \
        "4" "📱 Mobile Demo Mode" \
        "5" "🎬 Record Demo Session" \
        "0" "🔙 Back to Main Menu" \
        3>&1 1>&2 2>&3)
    
    case $choice in
        1) run_script "./scripts/sally-proof-live-demo.sh" "Sally Proof Live Demo" "Interactive demo for live presentations" ;;
        2) run_script "./scripts/sally-avalanche-ultimate-proof.sh" "Sally Avalanche Ultimate" "Comprehensive stress testing and proof of concept" ;;
        3) whiptail --title "🧪 Custom Tests" --msgbox "Custom test suite features coming soon!\n\nThis will include:\n- API endpoint testing\n- Database connectivity\n- File processing validation\n- Load testing" 12 50 ;;
        4) whiptail --title "📱 Mobile Demo" --msgbox "Mobile demo mode coming soon!\n\nThis will optimize the interface for:\n- Tablet presentations\n- Mobile device testing\n- Touch-friendly navigation" 12 50 ;;
        5) whiptail --title "🎬 Demo Recording" --msgbox "Demo recording features coming soon!\n\nThis will provide:\n- Screen recording\n- Automated demo scripts\n- Export to video formats" 12 50 ;;
    esac
}

# Documentation Menu
show_documentation() {
    local choice
    choice=$(whiptail --title "📚 Documentation" --menu "Documentation and Help:" 15 70 8 \
        "1" "📖 Quick Start Guide" \
        "2" "🔧 Troubleshooting Guide" \
        "3" "🌐 Service URLs Reference" \
        "4" "🔑 Default Credentials" \
        "5" "📁 File Structure" \
        "6" "❓ FAQ" \
        "0" "🔙 Back to Main Menu" \
        3>&1 1>&2 2>&3)
    
    case $choice in
        1)
            whiptail --title "📖 Quick Start Guide" --msgbox "🏔️ HELIX HUB QUICK START\n\n1. Start services: Menu → Service Management → Start All\n2. Wait 2-3 minutes for full startup\n3. Access services via Quick Access URLs\n4. Use Keycloak Manager for user setup\n5. Run Health Check to verify everything\n\nDefault admin credentials:\n- Keycloak: admin / admin123\n- Vault: Token 'myroot'\n- FileBrowser: admin / admin" 15 60
            ;;
        2)
            whiptail --title "🔧 Troubleshooting" --msgbox "🔧 COMMON ISSUES & SOLUTIONS\n\n❌ Services won't start:\n   → Check Docker is running\n   → Run: docker system prune -f\n\n❌ Web UI not loading:\n   → Check /etc/hosts entries\n   → Try direct localhost URLs\n\n❌ Database errors:\n   → Restart PostgreSQL container\n   → Check logs via menu\n\n❌ Keycloak admin spins:\n   → Use CLI manager instead\n   → Clear browser cache" 16 60
            ;;
        3) run_script "./scripts/quick-access.sh" "Service URLs" "Complete service URL reference" ;;
        4)
            whiptail --title "🔑 Default Credentials" --msgbox "🔑 DEFAULT SERVICE CREDENTIALS\n\n🔐 Keycloak:\n   Username: admin\n   Password: admin123\n\n🔒 Vault:\n   Root Token: myroot\n\n📁 FileBrowser:\n   Username: admin\n   Password: admin\n\n⚡ n8n:\n   Username: admin\n   Password: admin\n\n🗄️ PostgreSQL:\n   Username: helix\n   Password: helixpass" 16 50
            ;;
        5)
            local structure=$(mktemp)
            echo "📁 Helix Hub File Structure" > "$structure"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> "$structure"
            tree -L 3 . >> "$structure" 2>/dev/null || find . -type d -name ".*" -prune -o -type d -print | head -20 >> "$structure"
            whiptail --title "📁 File Structure" --textbox "$structure" 20 80
            rm "$structure"
            ;;
        6)
            whiptail --title "❓ FAQ" --msgbox "❓ FREQUENTLY ASKED QUESTIONS\n\nQ: How to reset everything?\nA: Menu → Maintenance → Docker Cleanup + Restart\n\nQ: Keycloak admin console won't load?\nA: Use Menu → Security → Keycloak Management (CLI)\n\nQ: How to add new users?\nA: Menu → Security → Keycloak Management\n\nQ: Services are slow?\nA: Menu → System Information → Performance\n\nQ: Need help with specific service?\nA: Menu → System Info → View Container Logs" 16 60
            ;;
    esac
}

# Main execution
main() {
    # Check if we're in the right directory
    if [[ ! -f "docker-compose.yml" ]]; then
        whiptail --title "❌ Error" --msgbox "Please run this script from the Helix Hub project root directory (where docker-compose.yml is located)." 8 60
        exit 1
    fi
    
    # Show title
    show_title
    
    # Show main menu
    show_main_menu
    
    # Exit message
    whiptail --title "🏔️ Goodbye" --msgbox "Thank you for using the Helix Hub Control Panel!\n\nBuilt with Swiss Engineering Excellence 🇨🇭\n\nRemember: Precision, Reliability, Innovation" 10 60
}

# Run the main function
main "$@"
