# Makefile for managing Docker containers with docker-compose

DOCKER_COMPOSE = docker-compose
APP_CONTAINER = locallink  # The named container

.PHONY: start clean build restart status help run

# Build the Docker images
build:
	@echo "Building Docker images..."
	@$(DOCKER_COMPOSE) build

# Start all Docker containers using docker-compose
start: build
	@echo "Starting all Docker containers..."
	@$(DOCKER_COMPOSE) up -d

# Stop and remove all Docker containers, networks, volumes, and images created by up
stop:
	@echo "Stopping and removing Docker containers, networks, and volumes..."
	@$(DOCKER_COMPOSE) down -v
	@echo "Cleaned up Docker containers, networks, and volumes."

# Restart all containers with a clean state
clean: stop start
	@echo "Restarted all Docker containers with a fresh state."

# Show status of all containers managed by docker-compose
status:
	@echo "Container Status:"
	@$(DOCKER_COMPOSE) ps --all

# Help command to list available options
help:
	@echo "Available commands:"
	@echo " make build     - Build Docker images for the project"
	@echo " make start     - Start all Docker containers in detached mode"
	@echo " make clean     - Stop, remove, and clear Docker containers, networks, and volumes"
	@echo " make restart   - Clean and restart all containers in detached mode"
	@echo " make status    - Show status of all containers"
	@echo " make help      - Show this help message"

# Run the Docker containers using docker-compose up
run:
	@echo "Running Docker containers..."
	@$(DOCKER_COMPOSE) up
