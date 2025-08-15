# HashiCorp Vault Configuration
# Enterprise secrets management for Helix Hub

# Vault server configuration
storage "file" {
  path = "/vault/data"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
ui = true

# Development mode - will be secured in production
disable_mlock = true
