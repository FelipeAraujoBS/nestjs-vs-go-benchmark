# Stage 1: Build
FROM golang:1.24-alpine AS builder  

WORKDIR /app

# Copia go.mod e go.sum primeiro (cache de dependências)
COPY go.mod go.sum ./
RUN go mod download

# Copia o código fonte
COPY . .

# Build do binário
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Stage 2: Runtime (imagem mínima)
FROM alpine:latest

WORKDIR /app

# Copia apenas o binário da stage anterior
COPY --from=builder /app/main .

# Expõe a porta
EXPOSE 8080

# Comando para rodar
CMD ["./main"]

