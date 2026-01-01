# 🚀 NestJS vs Go + Gin: Performance Benchmark

## 📋 Sobre o Projeto

Este repositório contém uma comparação de performance entre duas stacks populares para desenvolvimento de APIs REST:

- **NestJS** (Node.js + TypeScript)
- **Go + Gin**

O objetivo é avaliar e comparar o desempenho de ambas as tecnologias em cenários **CPU-bound** e **I/O-bound**, fornecendo dados reais e objetivos para auxiliar na escolha de tecnologia para diferentes tipos de aplicações.

## 🎯 Motivação

Escolher a stack certa pode impactar significativamente a performance, escalabilidade e custos de infraestrutura de uma aplicação. Este benchmark busca responder perguntas como:

- Qual stack é mais eficiente em operações que exigem processamento intensivo (CPU-bound)?
- Como cada tecnologia se comporta em operações de I/O (chamadas HTTP externas)?
- Qual o consumo de recursos (CPU e memória) de cada uma?
- Quais as diferenças em latência e throughput sob carga?

## 🧪 Testes Implementados

### 1. CPU-Bound: Cálculo de Números Primos

**Endpoint:** `GET /primes?n={número}`

Calcula todos os números primos até N, testando a capacidade de processamento computacional de cada stack.

**Exemplo:**

```bash
curl "http://localhost:8080/primes?n=100000"  # Go
curl "http://localhost:3000/primes?n=100000"  # NestJS
```

**Response:**

```json
{
  "count": 9592,
  "elapsedMs": 245
}
```

### 2. I/O-Bound: Requisições HTTP Externas

#### 2.1 Fetch de Todos os Posts

**Endpoint:** `GET /fetch`

Busca todos os posts da API pública JSONPlaceholder em uma única requisição.

**Exemplo:**

```bash
curl "http://localhost:8080/fetch"  # Go
curl "http://localhost:3000/fetch"  # NestJS
```

#### 2.2 Fetch Agregado (Paralelo)

**Endpoint:** `GET /aggregate`

Realiza 10 requisições HTTP em paralelo para buscar posts individuais, testando a capacidade de I/O concorrente.

**Exemplo:**

```bash
curl "http://localhost:8080/aggregate"  # Go
curl "http://localhost:3000/aggregate"  # NestJS
```

## 📊 Métricas Coletadas

- **RPS (Requests Per Second)**: Quantidade de requisições processadas por segundo
- **Latência Média**: Tempo médio de resposta
- **Percentis**: p50, p95 e p99 (distribuição de tempo de resposta)
- **Taxa de Erro**: Percentual de requisições que falharam
- **Uso de CPU**: Percentual de CPU utilizado durante os testes
- **Uso de Memória**: Consumo de memória RAM durante os testes

## 🏗️ Estrutura do Repositório

```
.
├── nest-api/                # Implementação em NestJS
│   ├── src/
│   │   ├── primes/         # Módulo de cálculo de primos
│   │   ├── fetch/          # Módulo de requisições HTTP
│   │   └── interceptors/   # Logging interceptor
│   ├── Dockerfile
│   └── package.json
├── go-gin/                  # Implementação em Go + Gin
│   ├── primes/             # Package de cálculo de primos
│   ├── fetch/              # Package de requisições HTTP
│   ├── server/             # Configuração do servidor
│   ├── Dockerfile
│   ├── go.mod
│   └── main.go
├── infrastructure/          # Docker Compose
│   └── docker-compose.yml
└── README.md
```

## 🚀 Como Executar

### Pré-requisitos

- Docker
- Docker Compose

### Subindo as Aplicações

```bash
# Clone o repositório
git clone
cd

# Suba ambas aplicações com Docker Compose
cd infrastructure
docker-compose up -d

# Verifique se estão rodando
docker-compose ps
```

### Executando o Benchmark

```bash
./benchmark.sh
```

Os resultados são salvos automaticamente em:

```txt
./benchmark-results/YYYYMMDD_HHMMSS/
```

# 🧠 Análise Geral

## Go + Gin

- **Excelente desempenho em CPU-bound**

- **Menor latência e maior previsibilidade**

- **Baixo overhead de runtime**

- **Muito eficiente em paralelismo explícito**

## NestJS

- **Desempenho superior em I/O-bound simples**

- **Alto throughput em endpoints leves**

- **Forte ecossistema e produtividade**

- **Overhead perceptível em workloads CPU-bound**

- **Conclusão: a escolha da stack deve considerar o tipo de carga predominante da aplicação, e não apenas benchmarks isolados.**

# ⚙️ Ambiente de Teste

Para evitar vieses:

**🐳 Docker Compose**

**🔒 CPU fixada por container**

**📦 Builds isolados**

**📊 Benchmark automatizado**

**🚫 Sem dependências externas além do HTTP**

Os resultados refletem diferenças reais de arquitetura e runtime, não variações do sistema operacional.

# 📌 Considerações Finais

Este projeto foi desenvolvido com foco em:

**Engenharia de performance**

**Avaliação técnica de stacks backend**

**Benchmark honesto e reproduzível**

Contribuições, melhorias e novos cenários de teste são bem-vindos.
