# 🚀 TypeScript + NestJS vs Go + Gin: Performance Benchmark

## 📋 Sobre o Projeto

Este repositório contém uma comparação de performance entre duas stacks populares para desenvolvimento de APIs REST:

- **TypeScript + NestJS** (Node.js)
- **Go + Gin**

O objetivo é avaliar e comparar o desempenho de ambas as tecnologias em cenários **CPU-bound** e **I/O-bound**, fornecendo dados reais e objetivos para auxiliar na escolha de tecnologia para diferentes tipos de aplicações.

## 🎯 Motivação

Escolher a stack certa pode impactar significativamente a performance, escalabilidade e custos de infraestrutura de uma aplicação. Este benchmark busca responder perguntas como:

- Qual stack é mais eficiente em operações que exigem processamento intensivo?
- Como cada tecnologia se comporta em operações de I/O (chamadas HTTP, leitura de arquivos)?
- Qual o consumo de recursos (CPU e memória) de cada uma?
- Quais as diferenças em latência e throughput?

## 🧪 Testes Implementados

### CPU-Bound

Testes focados em processamento computacional intensivo:

- Cálculo de números de Fibonacci (recursivo)
- Geração de números primos
- Operações de hashing (bcrypt)

### I/O-Bound

Testes focados em operações de entrada/saída:

- Chamadas HTTP para APIs externas
- Leitura e processamento de arquivos
- Requisições paralelas e agregação de dados

## 📊 Métricas Coletadas

- **RPS (Requests Per Second)**: Quantidade de requisições processadas por segundo
- **Latência**: p50, p95 e p99 (percentis de tempo de resposta)
- **Taxa de Erro**: Percentual de requisições que falharam
- **Uso de CPU**: Percentual de CPU utilizado durante os testes
- **Uso de Memória**: Consumo de memória RAM durante os testes

## 🏗️ Estrutura do Repositório

```
.
├── typescript-nestjs/       # Implementação em TypeScript + NestJS
├── go-gin/                  # Implementação em Go + Gin
├── benchmarks/              # Scripts e configurações de benchmark
│   ├── scripts/            # Scripts de automação
│   ├── configs/            # Configurações do Artillery
│   └── results/            # Resultados dos testes
├── infrastructure/          # Docker Compose e configs
└── docs/                    # Documentação detalhada
```
