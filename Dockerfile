FROM node:20-alpine
ARG USER_UID=1000
ARG USER_GID=1000

# Instala las dependencias básicas
RUN apk update && apk add --no-cache \
    bash \
    build-base \
    curl \
    docker-cli \
    gcc \
    git \
    make \
    nodejs \
    npm \
    openssh-client \
    python3 \
    py3-pip \
    vim
RUN chown -R node:node /usr/local/lib/node_modules
RUN chown -R node:node /usr/local/bin/


USER node
WORKDIR /app

# Instalar TypeSpec compiler y dependencias
RUN npm install -g @typespec/compiler
RUN npm install -g @typespec/http
RUN npm install -g @typespec/rest
RUN npm install -g @typespec/openapi3



EXPOSE 6500

CMD ["bash"]