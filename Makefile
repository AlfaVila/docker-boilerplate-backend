include .env

# Pass parameters to docker-compose
CURRENT_USER := $(shell id -un)
CURRENT_USERID := $(shell id -u)
export CURRENT_USER
export CURRENT_USERID

help:
	@echo ""
	@echo "Config File: .env"
	@echo ""
	@echo "Usage:"
	@echo "make up         - Start Development"
	@echo "make down       - Shutdown Server"
	@echo "make restart    - Restart Server"
	@echo "make sh         - Interactive mode on php image"
	@echo "make build      - Build Container image"
	echo ${CURRENT_USER}

# For Development
up:
	# Change .env Laravel file
	@sed -i "s/APP_NAME=.*/APP_NAME=${APP_NAME}/" ${APP_ENV_FILE}
	@sed -i "s/DB_CONNECTION=.*/DB_CONNECTION=${DB_CONNECTION}/" ${APP_ENV_FILE}
	@sed -i "s/DB_HOST=.*/DB_HOST=${DB_HOST}/" ${APP_ENV_FILE}
	@sed -i "s/DB_PORT=.*/DB_PORT=${DB_PORT}/" ${APP_ENV_FILE}
	@sed -i "s/DB_DATABASE=.*/DB_DATABASE=${DB_DATABASE}/" ${APP_ENV_FILE}
	@sed -i "s/DB_USERNAME=.*/DB_USERNAME=${DB_USERNAME}/" ${APP_ENV_FILE}
	@sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=${DB_PASSWORD}/" ${APP_ENV_FILE}

	docker compose -f docker-compose-dev.yml up -d

	# Change owner
	sudo chown -R ${USER}:82 ${APP_PATH}

down:
	docker compose -f docker-compose-dev.yml down

restart:
	docker compose -f docker-compose-dev.yml down
	docker compose -f docker-compose-dev.yml up -d

sh:
	@docker exec -it ${APP_NAME} sh

# For production
build:
	sudo chown -R ${USER} ${DB_PATH}
	docker compose -f docker-compose.yml -p ${APP_NAME} build
	#docker compose -f docker-compose.yml up -d
	#docker compose -f docker-compose.yml down
