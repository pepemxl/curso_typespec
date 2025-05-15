# dev variables
DOCKER_COMPOSE = docker-compose
CONTAINER_NAME = typespec-dev

# Variables para contenedor python
CONTAINER_NAME_PYTHON_DEV=python_dev
PYTHON_VERSION = 3.13

# Variables para contenedor java


# Variables para contenedor scala


# Variables para Load Testing
TEST_PATH = tests/
REPORTS_DIR = reports


.PHONY: build up down restart clean watch compile
.PHONY: build_python up_python down_python restart_python clean_python watch_python compile_python

build:
	$(DOCKER_COMPOSE) build

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

restart: down up

clean:
	$(DOCKER_COMPOSE) down -v
	rm -rf node_modules tsp-output

# Ejecutar el compilador en modo watch
watch:
	docker exec -it $(CONTAINER_NAME) tsp compile --watch src/main.tsp --output-dir tsp-output

# Compilar una sola vez
compile:
	docker exec -it $(CONTAINER_NAME) tsp compile src/main.tsp --output-dir tsp-output

# Entrar al contenedor
shell:
	docker exec -it $(CONTAINER_NAME) sh

# Instalar dependencias adicionales (ejemplo: @typespec/openapi3)
install:
	docker exec -it $(CONTAINER_NAME) npm install $(pkg)


# Construir la imagen con docker-compose
build_python:
	docker-compose build

# Levantar el contenedor en segundo plano
up_python:
	docker-compose up -d

# Conectar al contenedor con una terminal interactiva
shell_python:
	docker exec -it $(CONTAINER_NAME_PYTHON_DEV) bash

# Parar el contenedor
down_python:
	docker-compose down

# Eliminar el contenedor y la imagen
clean_python:
	docker-compose down --rmi all --volumes --remove-orphans

test-async:
#	pytest -p pytest_gevent_patch -asyncio-mode=auto
	pytest -p pytest_gevent_patch --gevent-patch -asyncio-mode=auto
#	Activa el monkey patch
#	pytest -p pytest_gevent_patch --gevent-patch tests/

test:
	docker exec -pytest tests/

test-docker:
	@mkdir -p $(REPORTS_DIR)
	docker run --rm \
		-v $(PWD):/app \
		-w /app \
		-e PYTHONPATH=/app \
		python:$(PYTHON_VERSION) \
		sh -c "pytest -p pytest_gevent_patch --gevent-patch -asyncio-mode=auto \
			--junitxml=$(REPORTS_DIR)/junit.xml \
			$(TEST_PATH)"