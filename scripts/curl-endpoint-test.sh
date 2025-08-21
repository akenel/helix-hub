

#!/bin/bash
# 🏔️ Helix Hub Swiss Emoji Curl Test Script
# All-in-one endpoint, workflow, and AI demo for Chuck, Marcel, and Levels

# --- Usage Help ---
if [[ "$1" == "--help" ]]; then
  echo -e "\nUsage: $0 [--model <model>] [--prompt <prompt>]"
  echo "  --model <model>   : Specify Ollama model (default: llama3.2:1b)"
  echo "  --prompt <prompt> : Specify prompt for Ollama (default: Wilhelm Tell)"
  echo "  --help            : Show this help message"
  echo -e "\nAvailable models:"
  ollama list
  exit 0
fi


# --- Default Model ---
DEFAULT_MODEL="llama3.2:1b"
# --- Parse Flags ---
PROMPT="Who is Wilhelm Tell - was he 1 in a million?"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --model) DEFAULT_MODEL="$2"; shift 2;;
    --prompt|--p) PROMPT="$2"; shift 2;;
    --chuck) MODEL=$DEFAULT_MODEL; PROMPT="Who is Chuck Norris and how many roundhouse kicks does he do per minute?"; shift;;
    --wilhelm) MODEL=$DEFAULT_MODEL; PROMPT="Who is Wilhelm Tell - was he 1 in a million?"; shift;;
    --swiss) MODEL=$DEFAULT_MODEL; PROMPT="What makes Switzerland unique in Europe?"; shift;;
    --mistral) MODEL=$DEFAULT_MODEL; PROMPT="What is the Mistral model and why is it good for Swiss banking?"; shift;;
    --llama) MODEL=$DEFAULT_MODEL; PROMPT="Explain the difference between llama3.2:1b and llama3.2:latest."; shift;;
    --levels) MODEL=$DEFAULT_MODEL; PROMPT="Who is Levels and why does he love coffee?"; shift;;
    --marcel) MODEL=$DEFAULT_MODEL; PROMPT="Who is Marcel and what is his favorite Swiss workflow?"; shift;;
    --angel) MODEL=$DEFAULT_MODEL; PROMPT="Who is Angel and why does he like bash scripts?"; shift;;
    --vault) MODEL=$DEFAULT_MODEL; PROMPT="What is HashiCorp Vault and why is it important for security?"; shift;;
    --keycloak) MODEL=$DEFAULT_MODEL; PROMPT="What is Keycloak and how does it help with authentication?"; shift;;
    --grafana) MODEL=$DEFAULT_MODEL; PROMPT="What is Grafana and why do Swiss engineers love it?"; shift;;
    --portainer) MODEL=$DEFAULT_MODEL; PROMPT="What is Portainer and how does it help with Docker management?"; shift;;
    --kong) MODEL=$DEFAULT_MODEL; PROMPT="What is Kong API Gateway and why is it powerful?"; shift;;
    --traefik) MODEL=$DEFAULT_MODEL; PROMPT="What is Traefik and how does it route Swiss traffic?"; shift;;
    *) shift;;
  esac
done

echo -e "\n🎪 =============================================== 🎪"
echo -e "🏔️ HELIX HUB SWISS CURL ENDPOINT DEMO"
echo -e "🎯 All-in-one: Service, Workflow, and AI Checks"
echo -e "===============================================\n"

# --- List Available Models ---
echo -e "🤖 Available Ollama Models:"
ollama list | awk 'NR==1{print $0}{print $1}' | column
echo -e "\n(Default: $DEFAULT_MODEL)"

SERVICES=(
  "helix.local:8443 helix.local:5000"
  "keycloak.helix.local:8443 keycloak:8080"
  "vault.helix.local:8443 vault:8200"
  "files.helix.local:8443 filebrowser:80"
  "n8n.helix.local:8443 n8n:5678"
  "traefik.helix.local:8443 traefik:8080"
  "kong.helix.local:8443 kong:8001"
  "portainer.helix.local:9443 portainer:9443"
  "grafana.helix.local:8443 grafana:3000"
  "prometheus.helix.local:8443 prometheus:9090"
)

# --- Chuck Curling Roundhouse Demo ---
# Default model is llama3.2:1b (free, works on most systems). Use --model tinyllama for smallest RAM.
DEFAULT_MODEL="llama3.2:1b"
if [[ "$1" == "--model" && "$2" == "llama3.2:1b" ]]; then
  DEFAULT_MODEL="llama3.2:1b"
fi
declare -A CHUCK_VARIATIONS=(
  [chuck]="$DEFAULT_MODEL|Who is Chuck Norris and how many roundhouse kicks does he do per minute?"
  [wilhelm]="$DEFAULT_MODEL|Who is Wilhelm Tell - was he 1 in a million?"
  [swiss]="$DEFAULT_MODEL|What makes Switzerland unique in Europe?"
  [mistral]="$DEFAULT_MODEL|What is the Mistral model and why is it good for Swiss banking?"
  [llama]="$DEFAULT_MODEL|Explain the difference between llama3.2:1b and llama3.2:latest."
  [levels]="$DEFAULT_MODEL|Who is Levels and why does he love coffee?"
  [marcel]="$DEFAULT_MODEL|Who is Marcel and what is his favorite Swiss workflow?"
  [angel]="$DEFAULT_MODEL|Who is Angel and why does he like bash scripts?"
  [vault]="$DEFAULT_MODEL|What is HashiCorp Vault and why is it important for security?"
  [keycloak]="$DEFAULT_MODEL|What is Keycloak and how does it help with authentication?"
  [grafana]="$DEFAULT_MODEL|What is Grafana and why do Swiss engineers love it?"
  [portainer]="$DEFAULT_MODEL|What is Portainer and how does it help with Docker management?"
  [kong]="$DEFAULT_MODEL|What is Kong API Gateway and why is it powerful?"
  [traefik]="$DEFAULT_MODEL|What is Traefik and how does it route Swiss traffic?"
)

for variant in "${!CHUCK_VARIATIONS[@]}"; do
  IFS='|' read -r model prompt <<< "${CHUCK_VARIATIONS[$variant]}"
  echo -e "\n🏹 =============================================== 🏹"
  echo -e "🏹 SWISS DEMO: n8n Workflow Test (POST) [$variant]"
  echo -e "🏹 ------------------------------------------------------"
  curl -sk -X POST https://n8n.helix.local:8443/webhook/PROD_n8n-base-sanity-check \
    -H "Content-Type: application/json" \
    -d '{"test":"sanity", "variant":"'$variant'"}' | jq .
  echo -e "🏹 ------------------------------------------------------"

  echo -e "\n🤖 =============================================== 🤖"
  echo -e "🤖 SWISS DEMO: Ollama AI Test (POST) [$variant]"
  echo -e "🤖 Model: $model"
  echo -e "🤖 Prompt: $prompt"
  echo -e "🤖 ------------------------------------------------------"
  curl -sk -X POST https://ollama.helix.local:8443/api/generate \
    -H "Content-Type: application/json" \
    -d "{\"model\":\"$model\",\"prompt\":\"$prompt\"}" | jq -r '.response // .error // "No response"' | tr -d '\n' | fold -s -w 80
  echo -e "🤖 ------------------------------------------------------"
done


# 🏹 SWISS DEMO: n8n Workflow Test (POST)
echo -e "\n🏹 =============================================== 🏹"
echo -e "🏹 SWISS DEMO: n8n Workflow Test (POST)"
echo -e "🏹 ------------------------------------------------------"
curl -sk -X POST https://n8n.helix.local:8443/webhook/PROD_n8n-base-sanity-check \
  -H "Content-Type: application/json" \
  -d '{"test":"sanity"}' | jq .
echo -e "🏹 ------------------------------------------------------"

# 🤖 SWISS DEMO: Ollama AI Test (POST)
echo -e "\n🤖 =============================================== 🤖"
echo -e "🤖 SWISS DEMO: Ollama AI Test (POST)"
echo -e "🤖 Model: $MODEL"
echo -e "🤖 Prompt: $PROMPT"
echo -e "🤖 ------------------------------------------------------"
curl -sk -X POST https://ollama.helix.local:8443/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":\"$PROMPT\"}" | jq -r '.response // .error // "No response"' | tr -d '\n' | fold -s -w 80
echo -e "🤖 ------------------------------------------------------"

# Swiss Demo: n8n Workflow Test (POST)
echo -e "\n🏹 SWISS DEMO: n8n Workflow Test (POST)"
echo "------------------------------------------------------"
curl -sk -X POST https://n8n.helix.local:8443/webhook/PROD_n8n-base-sanity-check \
  -H "Content-Type: application/json" \
  -d '{"test":"sanity"}'
echo "------------------------------------------------------"

# Swiss Demo: Ollama AI Test (POST)
echo -e "\n🏹 SWISS DEMO: Ollama AI Test (POST)"
echo "------------------------------------------------------"
curl -sk -X POST https://ollama.helix.local:8443/api/generate \
  -H "Content-Type: application/json" \
  -d '{"model":"llama3.2:1b","prompt":"Who is Wilhelm Tell - was he 1 in a million?"}' | jq -r '.response' | tr -d '\n' | fold -s -w 80
echo "------------------------------------------------------"
