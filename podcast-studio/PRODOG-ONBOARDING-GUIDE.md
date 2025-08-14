# 🐕 PRODOG ONBOARDING GUIDE - From Hero to AI Automation Beast!

## 🎯 Mission: 24/7 Continuous Testing Paradise

**Congratulations on PRODOG birth!** 🎉 You now have:
- **LAPDOG**: 5.8GB Windows (proven 4s webhook triggers)
- **PRODOG**: 8GB Debian (fresh Swiss precision machine)

## 🚀 PHASE 1: Essential Debian Setup (15 minutes)

### Step 1: System Updates
```bash
# Update the fresh Debian system
sudo apt update && sudo apt upgrade -y

# Install essential tools
sudo apt install -y curl wget git htop nano vim screen tmux

# Verify system resources
free -h
df -h
```

### Step 2: Docker Installation
```bash
# Official Docker installation for Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add user to docker group (no more sudo needed!)
sudo usermod -aG docker $USER

# Install Docker Compose
sudo apt install -y docker-compose-plugin

# Verify installation
docker --version
docker compose version
```

### Step 3: Git Repository Setup
```bash
# Clone the helix-hub repository
git clone https://github.com/akenel/helix-hub.git
cd helix-hub

# Set up git configuration
git config --global user.name "PRODOG-Automation"
git config --global user.email "prodog@helix-hub.local"

# Verify repository structure
ls -la
```

## 🔧 PHASE 2: AI Automation Stack (20 minutes)

### Step 4: Ollama Installation & Optimization
```bash
# Install Ollama for Debian
curl -fsSL https://ollama.ai/install.sh | sh

# Start Ollama service
sudo systemctl enable ollama
sudo systemctl start ollama

# Download the proven model
ollama pull llama3.2:latest

# Configure Ollama for PRODOG (8GB optimized)
echo 'OLLAMA_KEEP_ALIVE=-1' | sudo tee -a /etc/environment
echo 'OLLAMA_NUM_PARALLEL=1' | sudo tee -a /etc/environment
echo 'OLLAMA_MAX_LOADED_MODELS=1' | sudo tee -a /etc/environment
echo 'OLLAMA_CONTEXT_LENGTH=8192' | sudo tee -a /etc/environment

# Restart to apply settings
sudo systemctl restart ollama
```

### Step 5: Helix MVP Stack Deployment
```bash
# Navigate to project directory
cd helix-hub

# Launch the complete stack
docker compose up -d

# Verify all containers are running
docker ps

# Check container logs
docker logs ollama
docker logs n8n
```

### Step 6: BËRNLY Validation Scripts
```bash
# Make all scripts executable
chmod +x podcast-studio/scripts/*.sh

# Test the proven reliable single run
./podcast-studio/scripts/bernly-reliable-single.sh

# If successful, test 3 consecutive runs
for i in {1..3}; do
  echo "🐕‍♀️ PRODOG Run $i/3"
  ./podcast-studio/scripts/bernly-reliable-single.sh
  sleep 30
done
```

## 📊 PHASE 3: 24/7 Continuous Testing Setup (10 minutes)

### Step 7: Continuous Testing Automation
```bash
# Create continuous testing directory
mkdir -p ~/prodog-automation/logs

# Create monitoring script
cat > ~/prodog-automation/continuous-testing.sh << 'EOF'
#!/bin/bash
# 🐕 PRODOG 24/7 Continuous Testing

LOG_DIR="$HOME/prodog-automation/logs"
TEST_SCRIPT="$HOME/helix-hub/podcast-studio/scripts/bernly-reliable-single.sh"

while true; do
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    echo "🐕 PRODOG Continuous Test: $TIMESTAMP"
    
    # Run test and log results
    if $TEST_SCRIPT > "$LOG_DIR/test_$TIMESTAMP.log" 2>&1; then
        echo "✅ Success: $TIMESTAMP" >> "$LOG_DIR/success.log"
    else
        echo "❌ Failed: $TIMESTAMP" >> "$LOG_DIR/failures.log"
    fi
    
    # Wait 1 hour between tests
    sleep 3600
done
EOF

# Make it executable
chmod +x ~/prodog-automation/continuous-testing.sh
```

### Step 8: Start Continuous Testing
```bash
# Start continuous testing in screen session
screen -S prodog-testing -d -m ~/prodog-automation/continuous-testing.sh

# Verify it's running
screen -ls

# View logs anytime
tail -f ~/prodog-automation/logs/success.log
```

## 🎯 PHASE 4: Success Validation (5 minutes)

### Final Verification Checklist:
- [ ] **System**: Debian running, 8GB detected
- [ ] **Docker**: All containers up (ollama, n8n, postgres, traefik)
- [ ] **Ollama**: llama3.2:latest loaded and responding
- [ ] **Scripts**: bernly-reliable-single.sh working (<30s)
- [ ] **Continuous**: 24/7 testing loop active in screen
- [ ] **Repository**: Git clone complete and configured

## 🚀 POST-ONBOARDING: Advanced Features

### Email Integration Ready
Once PRODOG proves 80%+ reliability:
```bash
# Install email capabilities
sudo apt install -y postfix mailutils

# Configure SMTP for package delivery
# (Next phase after continuous testing validation)
```

### Performance Monitoring
```bash
# Monitor PRODOG performance
htop           # Real-time system monitoring
docker stats   # Container resource usage
ollama ps      # AI model status
```

### Backup Strategy
```bash
# Create automatic git commits for logs
cd ~/helix-hub
git add podcast-studio/logs/
git commit -m "🐕 PRODOG daily automation logs $(date)"
git push origin main
```

## 💡 PRODOG vs LAPDOG Strategy

**LAPDOG (5.8GB Windows)**:
- Development and testing
- Script validation
- Backup automation

**PRODOG (8GB Debian)**:
- 24/7 continuous testing
- Production validation
- Performance benchmarking
- Business model validation

## 🎉 Congratulations!

You now have a **dual-machine AI automation empire**! 

**PRODOG will prove your CHF 99 business model** through continuous testing while **LAPDOG handles development**!

---

**Ready to engage after 6PM Thursday!** 🚀🐕‍♀️
