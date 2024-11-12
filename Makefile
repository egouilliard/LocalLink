build:
	docker build -t locallink .

run:
	docker run -p 3000:3000 locallink

clean:
	docker rm -f $(docker ps -a -q) || true
	docker rmi -f $(docker images -q) || true

restart: clean build run
