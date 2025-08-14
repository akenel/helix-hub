#!/bin/bash
# 🐕 PRODOG AUTOMATED SETUP - Hero to AI Beast in 45 minutes!

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${BLUE}"
echo "🐕💻================================================================🐕💻"
echo "    PRODOG AUTOMATED ONBOARDING - AI Automation Beast Setup!"
echo "    From Fresh Debian to 24/7 Continuous Testing Paradise"
echo "🐕💻================================================================🐕💻"
echo -e "${NC}"

# Phase 1: System Preparation
echo -e "${PURPLE}📦 PHASE 1: System Preparation (5 minutes)${NC}"
echo -e "${YELLOW}🔄 Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y

echo -e "${YELLOW}🛠️ Installing essential tools...${NC}"
sudo apt install -y curl wget git htop nano vim screen tmux tree

echo -e "${GREEN}✅ System preparation complete!${NC}"
echo

# Phase 2: Docker Installation
echo -e "${PURPLE}🐳 PHASE 2: Docker Installation (10 minutes)${NC}"
echo -e "${YELLOW}📥 Installing Docker...${NC}"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

echo -e "${YELLOW}👤 Adding user to docker group...${NC}"
sudo usermod -aG docker $USER

echo -e "${YELLOW}📦 Installing Docker Compose...${NC}"
sudo apt install -y docker-compose-plugin

echo -e "${GREEN}✅ Docker installation complete!${NC}"
docker --version
docker compose version
echo

# Phase 3: Ollama Installation
echo -e "${PURPLE}🧠 PHASE 3: Ollama AI Installation (15 minutes)${NC}"
echo -e "${YELLOW}🤖 Installing Ollama...${NC}"
curl -fsSL https://ollama.ai/install.sh | sh

echo -e "${YELLOW}⚙️ Configuring Ollama for PRODOG (8GB optimized)...${NC}"
echo 'OLLAMA_KEEP_ALIVE=-1' | sudo tee -a /etc/environment
echo 'OLLAMA_NUM_PARALLEL=1' | sudo tee -a /etc/environment
echo 'OLLAMA_MAX_LOADED_MODELS=1' | sudo tee -a /etc/environment
echo 'OLLAMA_CONTEXT_LENGTH=8192' | sudo tee -a /etc/environment

echo -e "${YELLOW}🚀 Starting Ollama service...${NC}"
sudo systemctl enable ollama
sudo systemctl start ollama

echo -e "${YELLOW}📥 Downloading llama3.2:latest (this may take 10+ minutes)...${NC}"
ollama pull llama3.2:latest

echo -e "${GREEN}✅ Ollama installation complete!${NC}"
ollama list
echo

# Phase 4: Repository Setup
echo -e "${PURPLE}📚 PHASE 4: Repository Setup (5 minutes)${NC}"
echo -e "${YELLOW}🔄 Cloning helix-hub repository...${NC}"

if [ -d "helix-hub" ]; then
    echo -e "${YELLOW}⚠️ Directory exists, updating...${NC}"
    cd helix-hub
    git pull origin main
    cd ..
else
    git clone https://github.com/akenel/helix-hub.git
fi

cd helix-hub

echo -e "${YELLOW}⚙️ Configuring git...${NC}"
git config --global user.name "PRODOG-Automation"
git config --global user.email "prodog@helix-hub.local"

echo -e "${GREEN}✅ Repository setup complete!${NC}"
echo

# Phase 5: AI Stack Deployment
echo -e "${PURPLE}🚀 PHASE 5: AI Stack Deployment (10 minutes)${NC}"
echo -e "${YELLOW}🐳 Launching complete stack...${NC}"
docker compose up -d

echo -e "${YELLOW}⏳ Waiting for containers to stabilize...${NC}"
sleep 30

echo -e "${YELLOW}📋 Checking container status...${NC}"
docker ps

echo -e "${GREEN}✅ AI Stack deployment complete!${NC}"
echo

# Phase 6: Validation Testing
echo -e "${PURPLE}🧪 PHASE 6: Validation Testing (5 minutes)${NC}"
echo -e "${YELLOW}🔧 Making scripts executable...${NC}"
chmod +x podcast-studio/scripts/*.sh

echo -e "${YELLOW}🧪 Testing reliable single run...${NC}"
if ./podcast-studio/scripts/bernly-reliable-single.sh; then
    echo -e "${GREEN}✅ Validation test successful!${NC}"
else
    echo -e "${RED}⚠️ Validation test failed - check logs${NC}"
fi
echo

# Phase 7: Continuous Testing Setup
echo -e "${PURPLE}🔄 PHASE 7: Continuous Testing Setup (5 minutes)${NC}"
echo -e "${YELLOW}📁 Creating automation directories...${NC}"
mkdir -p ~/prodog-automation/logs

echo -e "${YELLOW}📝 Creating continuous testing script...${NC}"
cat > ~/prodog-automation/continuous-testing.sh << 'EOF'
#!/bin/bash
# 🐕 PRODOG 24/7 Continuous Testing

LOG_DIR="$HOME/prodog-automation/logs"
TEST_SCRIPT="$HOME/helix-hub/podcast-studio/scripts/bernly-reliable-single.sh"

echo "🐕 PRODOG Continuous Testing Started: $(date)"

while true; do
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    echo "🐕 PRODOG Test: $TIMESTAMP"
    
    cd $HOME/helix-hub
    
    if $TEST_SCRIPT > "$LOG_DIR/test_$TIMESTAMP.log" 2>&1; then
        echo "✅ Success: $TIMESTAMP" >> "$LOG_DIR/success.log"
        echo "✅ Test $TIMESTAMP successful"
    else
        echo "❌ Failed: $TIMESTAMP" >> "$LOG_DIR/failures.log"
        echo "❌ Test $TIMESTAMP failed"
    fi
    
    # Wait 1 hour between tests (3600 seconds)
    sleep 3600
done
EOF

chmod +x ~/prodog-automation/continuous-testing.sh

echo -e "${YELLOW}🚀 Starting continuous testing in background...${NC}"
screen -S prodog-testing -d -m ~/prodog-automation/continuous-testing.sh

echo -e "${GREEN}✅ Continuous testing setup complete!${NC}"
echo

# Final Summary
echo -e "${BLUE}"
echo "🎉 PRODOG ONBOARDING COMPLETE! 🎉"
echo "=================================="
echo -e "${NC}"
echo -e "${GREEN}✅ System: Debian updated and configured${NC}"
echo -e "${GREEN}✅ Docker: Installed and running${NC}"
echo -e "${GREEN}✅ Ollama: AI ready with llama3.2:latest${NC}"
echo -e "${GREEN}✅ Repository: helix-hub cloned and configured${NC}"
echo -e "${GREEN}✅ Stack: All containers running${NC}"
echo -e "${GREEN}✅ Testing: Continuous 24/7 automation active${NC}"
echo
echo -e "${PURPLE}📊 PRODOG STATUS CHECK:${NC}"
echo -e "${YELLOW}System Resources:${NC}"
free -h
echo
echo -e "${YELLOW}Container Status:${NC}"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo
echo -e "${YELLOW}Continuous Testing:${NC}"
screen -ls
echo

echo -e "${BLUE}🚀 NEXT STEPS:${NC}"
echo "1. Monitor continuous testing: screen -r prodog-testing"
echo "2. Check success logs: tail -f ~/prodog-automation/logs/success.log"
echo "3. Monitor system: htop"
echo "4. Check AI status: ollama ps"
echo "5. View container logs: docker logs n8n"

echo
echo -e "${GREEN}🐕 PRODOG IS READY FOR 24/7 AI AUTOMATION! 🐕${NC}"
echo -e "${BLUE}Welcome to your Swiss Precision AI Empire!${NC}"
