# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

# Copia package.json e package-lock.json
COPY package*.json ./

# Instala dependências
RUN npm ci

# Copia código fonte
COPY . .

# Build da aplicação
RUN npm run build

# Stage 2: Runtime
FROM node:20-alpine

WORKDIR /app

# Copia package.json
COPY package*.json ./

# Instala apenas dependências de produção
RUN npm ci --only=production

# Copia o build da stage anterior
COPY --from=builder /app/dist ./dist

# Expõe a porta
EXPOSE 3000

# Comando para rodar
CMD ["node", "dist/main.js"]