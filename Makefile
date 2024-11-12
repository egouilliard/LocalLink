# Makefile for managing Docker containers with a specific container name

DOCKER_COMPOSE = docker-compose
APP_CONTAINER = Locallink  # The named container

.PHONY: build run clean restart status help

# Build the Docker image
build:
	@echo "Building Docker image..."
	@docker build -t locallink .

# Run the Docker container in detached mode
run:
	@echo "Starting Docker container in detached mode..."
	@docker-compose up -d postgres pgadmin
	@docker run -d -p 3000:3000 --name $(APP_CONTAINER) locallink

# Stop, remove containers, and clear images/volumes
clean:
	@echo "Stopping and removing the $(APP_CONTAINER) container..."
	@docker rm -f $(APP_CONTAINER) || true
	@docker-compose down --volumes --remove-orphans
	@docker rmi -f $(docker images -q) || true
	@docker volume rm $(docker volume ls -q) || true
	@echo "Cleaned up Docker containers, images, and volumes."

# Restart the application with a clean state
restart: clean build run
	@echo "Rebuilding and starting the $(APP_CONTAINER) container in detached mode..."

# Show status of the container
status:
	@echo "Container Status:"
	@$(DOCKER_COMPOSE) ps --all --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}" | \
		awk 'NR==1 {print "NAME\tSTATUS\tPORTS"} NR>1 {name=$$1; status=$$2; ports=$$NF; if (status == "Up") {status = "\033[0;32mUp\033[0m"} else {status = "\033[0;31mDown\033[0m"}; print name "\t" status "\t" ports}'

# Help command to list available options
help:
	@echo "Available commands:"
	@echo " make build     - Build the Docker image"
	@echo " make run       - Run the Docker container in detached mode"
	@echo " make clean     - Stop, remove, and clear Docker containers, images, and volumes"
	@echo " make restart   - Clean, rebuild, and restart the application in detached mode"
	@echo " make status    - Show status of the container"
	@echo " make help      - Show this help message"
