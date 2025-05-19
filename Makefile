up:
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

d:
	docker compose -f srcs/docker-compose.yml down --volumes
	docker image prune -a -f
