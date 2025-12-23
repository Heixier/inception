DOCKER_COMPOSE="./srcs/docker-compose.yml"
VOLUMES="/home/rsiah/data"
DB_PATH="$(VOLUMES)/mariadb"
WP_PATH="$(VOLUMES)/wordpress"

all: start

start:
	mkdir -p $(DB_PATH)
	mkdir -p $(WP_PATH)
	docker compose -f $(DOCKER_COMPOSE) up --build

stop:
	docker compose -f $(DOCKER_COMPOSE) down

restart: stop start

.PHONY: start stop restart 
