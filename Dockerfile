FROM node:20-alpine

WORKDIR /app

# Instalar TypeSpec compiler y dependencias
RUN npm install -g @typespec/compiler

# Instalar dependencias del proyecto
COPY package.json package-lock.json ./
RUN npm install

COPY ./src .

EXPOSE 6500

CMD ["npm", "run", "dev"]  # Este sera sobre-escrito por docker-compose lo agregamos para pruebas 