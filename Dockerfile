FROM node:20-alpine
ARG USER_UID=1000
ARG USER_GID=1000

# Instala las dependencias básicas
RUN apk update && apk add --no-cache \
    bash \
    git \
    curl \
    openssh-client \
    nodejs \
    npm \
    python3 \
    py3-pip \
    build-base \
    gcc \
    make \
    docker-cli \
    vim
RUN chown -R node:node /usr/local/lib/node_modules
RUN chown -R node:node /usr/local/bin/


USER node
WORKDIR /app

# Instalar TypeSpec compiler y dependencias
RUN npm install -g @typespec/compiler

EXPOSE 6500

CMD ["bash"]