# Local Python To be updated
PY := python3.10
VENV := venv
UID := $(shell id -u)
GID := $(shell id -g)
REPONAME=$(basename $(pwd))
DOCKER=docker
DOCKER_COMPOSE = docker-compose

# dev variables
CONTAINER_NAME = typespec-dev

# Variables para contenedor curso-typespec-doc
CONTAINER_NAME_CURSO_TYPESPEC_DOC=curso_typespec_doc

# Variables para contenedor python
CONTAINER_NAME_PYTHON_DEV=python_dev
PYTHON_VERSION = 3.13

# Variables para contenedor java


# Variables para contenedor scala


# Variables para Load Testing
TEST_PATH = tests/
REPORTS_DIR = reports


.PHONY: build up down restart clean watch compile
.PHONY: build_docs up_docs down_docs restart_docs clean_docs
.PHONY: build_python up_python down_python restart_python clean_python watch_python compile_python

build:
	UID=$(UID) GID=$(GID) $(DOCKER_COMPOSE) build

up:
	UID=$(UID) GID=$(GID) $(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

restart: down up

clean:
	$(DOCKER_COMPOSE) down -v
	rm -rf node_modules tsp-output

# Ejecutar el compilador en modo watch
watch:
	docker exec -it $(CONTAINER_NAME) tsp compile --watch main.tsp --output-dir tsp-output

# Compilar una sola vez
compile:
	docker exec -it $(CONTAINER_NAME) tsp compile main.tsp --output-dir tsp-output

# Entrar al contenedor
shell:
	docker exec -it $(CONTAINER_NAME) sh

# Instalar dependencias adicionales (ejemplo: @typespec/openapi3)
install:
	docker exec -it $(CONTAINER_NAME) npm install $(pkg)

############# Docs ############
DOCKERFILE_DIR_DOCS := ./src/containers/docs
IMAGE_NAME_DOCS := typespec-docs
CONTAINER_NAME_DOCS := typespec-docs
PORT_DOCS := 8080

# Construye la imagen Docker usando el Dockerfile en /src/containers/docs/
build_docs:
	$(DOCKER) build -t $(IMAGE_NAME_DOCS) -f $(DOCKERFILE_DIR_DOCS)/Dockerfile .

# Levanta el contenedor y expone el puerto 8080 (con live-reload y montado de volumen)
run_docs:
#	 $(DOCKER) run --rm -it -p $(PORT_DOCS):$(PORT_DOCS) -v $(PWD):/app $(IMAGE_NAME_DOCS)
	$(DOCKER) run --rm -it \
		--name $(CONTAINER_NAME_DOCS) \
		-p $(PORT_DOCS):$(PORT_DOCS) \
		-v $(PWD):/app \
		$(IMAGE_NAME_DOCS)

# Detiene y elimina el contenedor (si está en segundo plano)
clean_docs:
	$(DOCKER) stop $(CONTAINER_NAME_DOCS) || true
	$(DOCKER) rm $(IMAGE_NAME_DOCS) || true

# Atajo para build + run
up_docs: build_docs run_docs




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


clean-docer:
	docker system prune -af
# docker image prune -a ; \
# docker network prune -f ; \
# docker volume prune -f '