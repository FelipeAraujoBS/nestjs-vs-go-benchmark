# 🚀 Benchmark: NestJS vs Go (Gin)

Este repositório apresenta um **benchmark prático e reproduzível** comparando **NestJS (Node.js)** e **Go + Gin** em cenários **CPU-bound** e **I/O-bound**, executados em **containers Docker com CPU fixada**, garantindo um ambiente justo e controlado.

O objetivo **não é declarar um “vencedor absoluto”**, mas demonstrar **como diferentes stacks se comportam sob cargas distintas**, evidenciando seus pontos fortes e limitações.

---

## 🎯 Objetivos do Projeto

- Comparar **performance real** entre NestJS e Go + Gin
- Avaliar comportamento em:
  - 🔢 **CPU-bound** (cálculo intensivo)
  - 🌐 **I/O-bound** (requisições simples)
  - 🔄 **I/O-bound com paralelismo** (agregações)
- Garantir **fair play**:
  - Containers Docker
  - CPU fixada por serviço
  - Mesmo volume de requisições
- Servir como **estudo técnico e material de portfólio**

---

## 🧪 Cenários de Benchmark

### 🔢 CPU-Bound — Cálculo de Primos

- Endpoint responsável por calcular números primos até `n = 100000`
- Testa:
  - Uso intensivo de CPU
  - Escalabilidade sob concorrência
  - Latência em tarefas computacionalmente pesadas

### 🌐 I/O-Bound — Fetch Simples

- Endpoint leve, sem processamento pesado
- Simula:
  - APIs REST comuns
  - Overhead de framework
  - Tempo de resposta puro

### 🔄 I/O-Bound — Aggregate Paralelo

- Endpoint que realiza múltiplas requisições em paralelo
- Avalia:
  - Concorrência
  - Modelo de execução assíncrona
  - Eficiência em orquestração de I/O

---

## ⚙️ Ambiente Controlado

Para evitar vieses de benchmark:

- 🐳 **Docker Compose**
- 🔒 **CPU fixada por container**
- 📦 Builds separados e isolados
- 🚫 Sem dependência externa
- 📊 Benchmark automatizado via script

> Isso garante que os resultados reflitam **características reais da stack**, e não variações do sistema operacional ou scheduler.

---

## 📊 Resultados (Run 3 — CPU Fixada)

### 🔢 CPU-Bound (Primos)

| Stack        | Requests/sec | Latência Média |
| ------------ | ------------ | -------------- |
| **Go + Gin** | ~352.8       | ~0.21s         |
| **NestJS**   | ~59.4        | ~0.94s         |

➡️ **Go domina tarefas CPU-bound**, com maior throughput e menor latência.

---

### 🌐 I/O-Bound (Fetch)

| Stack        | Requests/sec |
| ------------ | ------------ |
| **NestJS**   | ~1564.9      |
| **Go + Gin** | ~135.7       |

➡️ **NestJS se destaca fortemente em I/O simples**, graças ao event loop e modelo assíncrono.

---

### 🔄 I/O-Bound (Aggregate)

| Stack        | Requests/sec |
| ------------ | ------------ |
| **Go + Gin** | ~127.2       |
| **NestJS**   | ~43.1        |

➡️ Go mostra vantagem quando há **coordenação paralela com menor overhead**.

---

## 🧠 Conclusões

- **Go + Gin**

  - Excelente para **CPU-bound**
  - Baixo overhead
  - Alta previsibilidade sob carga

- **NestJS**
  - Extremamente eficiente em **I/O-bound**
  - Ideal para APIs REST tradicionais
  - Alta produtividade e ecossistema robusto

> **A escolha da stack deve considerar o tipo de carga**, não apenas benchmarks isolados.

---

## 🛠️ Como Executar

```bash
docker-compose up --build
./benchmark.sh
```
