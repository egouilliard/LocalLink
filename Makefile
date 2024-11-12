# Makefile for managing Docker containers

# Variables
DOCKER_COMPOSE = docker-compose
WEB_SERVICE = web

# Colors for pretty output
GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[0;33m
NC = \033[0m # No Color

.PHONY: build run clean restart status help

# Build the Docker image
build:
	@echo "$(YELLOW)Building Docker image...$(NC)"
	@docker build -t locallink .

# Run the Docker container
run:
	@echo "$(GREEN)Starting Docker container...$(NC)"
	@docker run -p 3000:3000 locallink

# Stop, remove containers, and clear images/volumes
clean:
	@echo "$(RED)Stopping and removing all containers...$(NC)"
	@docker rm -f $(docker ps -a -q) || true
	@docker rmi -f $(docker images -q) || true
	@docker volume rm $(docker volume ls -q) || true
	@echo "$(GREEN)Cleaned up Docker containers, images, and volumes.$(NC)"

# Restart the application with clean state
restart: clean build run
	@echo "$(YELLOW)Rebuilding and starting all containers...$(NC)"

# Show status of containers
status:
	@echo "$(YELLOW)Container Status:$(NC)"
	@$(DOCKER_COMPOSE) ps --all --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}" | \
		awk 'NR==1 {print "NAME\tSTATUS\tPORTS"} NR>1 {name=$$1; status=$$2; ports=$$NF; if (status == "Up") {status = "$(GREEN)Up$(NC)"} else {status = "$(RED)Down$(NC)"}; print name "\t" status "\t" ports}'

# Help command to list available options
help:
	@echo "Available commands:"
	@echo " make build     - Build the Docker image"
	@echo " make run       - Run the Docker container"
	@echo " make clean     - Stop, remove, and clear Docker containers, images, and volumes"
	@echo " make restart   - Clean, rebuild, and restart the application"
	@echo " make status    - Show status of all containers"
	@echo " make help      - Show this help message"
