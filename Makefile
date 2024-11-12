build:
	docker build -t locallink .

run:
	docker run -p 3000:3000 locallink
