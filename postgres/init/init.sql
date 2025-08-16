-- Init script for Postgres: create Keycloak database and user
-- This script will run automatically when the Postgres data volume is first initialized.
-- If your volume already existed, either recreate the volume or apply the statements manually
-- against the running Postgres container (instructions below).

-- Create Keycloak database
CREATE DATABASE keycloak_db;

-- Create Keycloak user with password used in docker-compose.yml
DO
$$
BEGIN
	IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'keycloak_user') THEN
		CREATE ROLE keycloak_user LOGIN ENCRYPTED PASSWORD 'keycloak_secure_pass';
	END IF;
END
$$;

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE keycloak_db TO keycloak_user;

-- End of init.sql
