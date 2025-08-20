# Helix Hub LMS Lessons Learned ☕️📚

Welcome to the LMS knowledge base! Here you'll find hard-won tips, gotchas, and best practices from our journey integrating Moodle with Docker, Traefik, and PostgreSQL.

## 🚀 Quick Wins
- **Switching Moodle DB:** Use PostgreSQL for better compatibility and performance. Clean up old MariaDB volumes before switching.
- **Postgres Users & Creds:** Always create a dedicated DB and user for Moodle. Test connectivity with `psql` inside the container.
- **Docker Compose Tips:** Double-check environment variables and `depends_on` blocks. Restart containers after major changes.
- **Traefik Routing:** Update `dynamic.yml` for new services and endpoints. Use health checks and endpoint scripts for QA.

## 🦸‍♂️ Gotchas
- Old DB volumes can block new DB initialization—remove them before switching engines.
- Moodle needs correct DB host, user, and password—check logs for connection errors.
- Traefik config changes require container restarts to take effect.

## ☕️ Pro Tips
- Use clear commit messages for infra changes.
- Document every major troubleshooting step.
- Celebrate successful installs with coffee and emojis!

## 📋 Example: Postgres User Setup
```bash
# Inside postgres container
psql -U postgres
CREATE DATABASE moodle;
CREATE USER moodleuser WITH PASSWORD 'yourpassword';
GRANT ALL PRIVILEGES ON DATABASE moodle TO moodleuser;
```

## 📝 Add your own lessons below!

---
Feel free to contribute more tips, scripts, and fun facts. Every lesson saves a coffee!
