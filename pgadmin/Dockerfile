FROM dpage/pgadmin4

USER root

# Copy the custom entrypoint script into the container
COPY entrypoint.sh /custom-entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /custom-entrypoint.sh

# Use the custom entrypoint script to start pgAdmin with preconfiguration
ENTRYPOINT ["sh", "/custom-entrypoint.sh"]
