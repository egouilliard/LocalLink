#!/bin/bash

# Create the servers.json file from environment variables
cat > /pgadmin4/servers.json << EOF
{
    "Servers": {
      "1": {
        "Name": "${POSTGRES_SERVER_NAME:-PostgresDocker}",
        "Group": "Servers",
        "Host": "${POSTGRES_HOST:-postgres}",
        "Port": ${POSTGRES_PORT:-5432},
        "MaintenanceDB": "${POSTGRES_DB:-locallink}",
        "Username": "${POSTGRES_USER:-locallink_user}",
        "Password": "${POSTGRES_PASSWORD:-locallink_password}",
        "SSLMode": "prefer"
      }
    }
}
EOF

# Ensure correct ownership of servers.json
chown pgadmin:root /pgadmin4/servers.json
chmod 600 /pgadmin4/servers.json

# Start pgAdmin
exec /entrypoint.sh "$@"
