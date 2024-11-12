build:
	docker build -t locallink .

run:
	docker run -p 3000:3000 locallink

clean:
	@echo "Stopping and removing all containers..."
	@docker rm -f $(docker ps -a -q) || true
	@docker rmi -f $(docker images -q) || true
	@docker volume rm $(docker volume ls -q) || true

restart: clean build run
	@echo "Rebuilding and starting all containers..."
