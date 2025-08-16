#!/bin/bash

# 🦁 Keycloak Lion's Den Management Script - Wilhelm Tell Edition
# Swiss precision for Keycloak administration via CLI
# Author: Angel (Master of 41 Years Tunnel Engineering) & GitHub Copilot

set -e

CONTAINER="helix-hub-keycloak-1"
KCADM="docker exec $CONTAINER /opt/keycloak/bin/kcadm.sh"

# Colors for Swiss quality output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${PURPLE}🦁========================================🦁${NC}"
    echo -e "${PURPLE}    KEYCLOAK LION'S DEN MANAGEMENT${NC}"
    echo -e "${PURPLE}🦁========================================🦁${NC}"
    echo
}

print_section() {
    echo -e "${YELLOW}🔧 $1${NC}"
    echo "=============================================="
}

# Function to list all users
list_users() {
    print_section "USERS IN HELIX REALM"
    $KCADM get users -r helix --fields username,email,enabled,firstName,lastName | jq -r '.[] | "👤 \(.username) | \(.email) | Enabled: \(.enabled) | \(.firstName // "N/A") \(.lastName // "N/A")"'
    echo
}

# Function to list all roles
list_roles() {
    print_section "ROLES IN HELIX REALM"
    $KCADM get roles -r helix | jq -r '.[] | "🎭 \(.name) | \(.description // "No description")"'
    echo
}

# Function to list all clients
list_clients() {
    print_section "CLIENTS IN HELIX REALM"
    $KCADM get clients -r helix --fields clientId,enabled,description | jq -r '.[] | "🔧 \(.clientId) | Enabled: \(.enabled) | \(.description // "No description")"'
    echo
}

# Function to show user roles
show_user_roles() {
    local username=$1
    if [ -z "$username" ]; then
        echo -e "${RED}❌ Username required${NC}"
        return 1
    fi
    
    print_section "ROLES FOR USER: $username"
    $KCADM get-roles -r helix --uusername "$username" | jq -r '.[] | "🎭 \(.name) | \(.description // "No description")"'
    echo
}

# Function to create user
create_user() {
    local username=$1
    local email=$2
    local firstname=$3
    local lastname=$4
    local password=$5
    
    if [ -z "$username" ] || [ -z "$email" ] || [ -z "$password" ]; then
        echo -e "${RED}❌ Usage: create_user <username> <email> <firstname> <lastname> <password>${NC}"
        return 1
    fi
    
    print_section "CREATING USER: $username"
    
    # Create user
    user_id=$($KCADM create users -r helix \
        -s username="$username" \
        -s enabled=true \
        -s email="$email" \
        -s firstName="${firstname:-$username}" \
        -s lastName="${lastname:-User}" \
        -i)
    
    # Set password
    $KCADM set-password -r helix --username "$username" --new-password "$password"
    
    echo -e "${GREEN}✅ User '$username' created successfully with ID: $user_id${NC}"
    echo
}

# Function to assign role to user
assign_role() {
    local username=$1
    local rolename=$2
    
    if [ -z "$username" ] || [ -z "$rolename" ]; then
        echo -e "${RED}❌ Usage: assign_role <username> <rolename>${NC}"
        echo -e "${BLUE}Available roles: banking-admin, banking-user, monitoring-admin${NC}"
        return 1
    fi
    
    print_section "ASSIGNING ROLE: $rolename TO $username"
    $KCADM add-roles -r helix --uusername "$username" --rolename "$rolename"
    echo -e "${GREEN}✅ Role '$rolename' assigned to '$username'${NC}"
    echo
}

# Function to remove role from user
remove_role() {
    local username=$1
    local rolename=$2
    
    if [ -z "$username" ] || [ -z "$rolename" ]; then
        echo -e "${RED}❌ Usage: remove_role <username> <rolename>${NC}"
        return 1
    fi
    
    print_section "REMOVING ROLE: $rolename FROM $username"
    $KCADM remove-roles -r helix --uusername "$username" --rolename "$rolename"
    echo -e "${GREEN}✅ Role '$rolename' removed from '$username'${NC}"
    echo
}

# Function to reset user password
reset_password() {
    local username=$1
    local new_password=$2
    
    if [ -z "$username" ] || [ -z "$new_password" ]; then
        echo -e "${RED}❌ Usage: reset_password <username> <new_password>${NC}"
        return 1
    fi
    
    print_section "RESETTING PASSWORD FOR: $username"
    $KCADM set-password -r helix --username "$username" --new-password "$new_password"
    echo -e "${GREEN}✅ Password reset for '$username'${NC}"
    echo
}

# Function to enable/disable user
toggle_user() {
    local username=$1
    local enabled=$2
    
    if [ -z "$username" ] || [ -z "$enabled" ]; then
        echo -e "${RED}❌ Usage: toggle_user <username> <true|false>${NC}"
        return 1
    fi
    
    print_section "SETTING USER $username TO: $enabled"
    user_id=$($KCADM get users -r helix -q username="$username" | jq -r '.[0].id')
    $KCADM update users/"$user_id" -r helix -s enabled="$enabled"
    echo -e "${GREEN}✅ User '$username' enabled status set to: $enabled${NC}"
    echo
}

# Main menu function
show_menu() {
    print_header
    echo -e "${CYAN}🎯 KEYCLOAK MANAGEMENT OPTIONS:${NC}"
    echo "1. List all users"
    echo "2. List all roles" 
    echo "3. List all clients"
    echo "4. Show user roles"
    echo "5. Create new user"
    echo "6. Assign role to user"
    echo "7. Remove role from user"
    echo "8. Reset user password"
    echo "9. Enable/disable user"
    echo "10. Exit"
    echo
}

# Interactive mode
interactive_mode() {
    while true; do
        show_menu
        read -p "🦁 Choose an option (1-10): " choice
        echo
        
        case $choice in
            1) list_users ;;
            2) list_roles ;;
            3) list_clients ;;
            4) 
                read -p "Enter username: " username
                show_user_roles "$username"
                ;;
            5)
                read -p "Enter username: " username
                read -p "Enter email: " email
                read -p "Enter first name: " firstname
                read -p "Enter last name: " lastname
                read -s -p "Enter password: " password
                echo
                create_user "$username" "$email" "$firstname" "$lastname" "$password"
                ;;
            6)
                read -p "Enter username: " username
                read -p "Enter role name (banking-admin|banking-user|monitoring-admin): " rolename
                assign_role "$username" "$rolename"
                ;;
            7)
                read -p "Enter username: " username
                read -p "Enter role name to remove: " rolename
                remove_role "$username" "$rolename"
                ;;
            8)
                read -p "Enter username: " username
                read -s -p "Enter new password: " password
                echo
                reset_password "$username" "$password"
                ;;
            9)
                read -p "Enter username: " username
                read -p "Enable user? (true/false): " enabled
                toggle_user "$username" "$enabled"
                ;;
            10)
                echo -e "${GREEN}🦁 Exiting Keycloak Management. Stay Swiss! 🇨🇭${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Invalid option. Please choose 1-10.${NC}"
                echo
                ;;
        esac
        
        read -p "Press Enter to continue..."
        clear
    done
}

# Command line usage
usage() {
    echo "Usage: $0 [COMMAND] [ARGS...]"
    echo
    echo "Commands:"
    echo "  list-users                           - List all users"
    echo "  list-roles                           - List all roles"
    echo "  list-clients                         - List all clients"
    echo "  user-roles <username>                - Show roles for user"
    echo "  create-user <user> <email> <first> <last> <pass> - Create new user"
    echo "  assign-role <username> <rolename>    - Assign role to user"
    echo "  remove-role <username> <rolename>    - Remove role from user"
    echo "  reset-password <username> <password> - Reset user password"
    echo "  toggle-user <username> <true|false>  - Enable/disable user"
    echo "  interactive                          - Interactive mode"
    echo
    echo "Examples:"
    echo "  $0 list-users"
    echo "  $0 create-user john john@helix.local John Doe mypassword"
    echo "  $0 assign-role john banking-user"
    echo "  $0 interactive"
}

# Parse command line arguments
case "${1:-interactive}" in
    list-users) list_users ;;
    list-roles) list_roles ;;
    list-clients) list_clients ;;
    user-roles) show_user_roles "$2" ;;
    create-user) create_user "$2" "$3" "$4" "$5" "$6" ;;
    assign-role) assign_role "$2" "$3" ;;
    remove-role) remove_role "$2" "$3" ;;
    reset-password) reset_password "$2" "$3" ;;
    toggle-user) toggle_user "$2" "$3" ;;
    interactive) interactive_mode ;;
    help|--help|-h) usage ;;
    *) 
        echo -e "${RED}❌ Unknown command: $1${NC}"
        echo
        usage
        exit 1
        ;;
esac
