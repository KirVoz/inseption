all: dirs start

dirs:
	mkdir -p "${HOME}/data/wp-data"
	mkdir -p "${HOME}/data/db-data"

down:
	docker compose -f srcs/docker-compose.yml down

d:
	docker compose -f srcs/docker-compose.yml down --volumes
	sudo rm -rf "${HOME}/data/wp-data"
	sudo rm -rf "${HOME}/data/db-data"
	docker system prune -a --volumes

stop:
	docker compose -f srcs/docker-compose.yml stop
start:
	docker compose -f srcs/docker-compose.yml up -d --build
restart:
	docker compose -f srcs/docker-compose.yml restart
ps:
	docker ps
logs:
	docker compose -f srcs/docker-compose.yml logs -fma

db:
	docker exec -it mariadb mariadb -ukvoznese -p123 wpdb
	#SHOW DATABASES;
	#USE wpdb;
	#SHOW TABLES;
	#SELECT * FROM wp_users;
	#exit;

.PHONY: init_dirs down d stop start restart ps logs db