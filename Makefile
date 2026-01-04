DOCKER_COMPOSE="./srcs/docker-compose.yml"
DATA_PATH="./data"
DB_PATH="$(DATA_PATH)/mariadb"
WP_PATH="$(DATA_PATH)/wordpress"

all: start

start:
	mkdir -p $(DB_PATH)
	mkdir -p $(WP_PATH)
	docker compose -f $(DOCKER_COMPOSE) up --build

stop:
	docker compose -f $(DOCKER_COMPOSE) down

clean:
	docker compose -f $(DOCKER_COMPOSE) down -v --rmi all

fclean: clean 
	rm -rf $(DATA_PATH)

restart: stop start

.PHONY: start stop fclean clean restart 
