#!/bin/bash

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "═══════════════════════════════════════════════════════"
echo -e "${BLUE}🚀 Benchmark: NestJS vs Go + Gin${NC}"
echo "═══════════════════════════════════════════════════════"
echo ""

# Verifica se as aplicações estão rodando
echo "Verificando aplicações..."
if ! curl -s http://localhost:8080/primes?n=10 > /dev/null; then
    echo -e "${RED}❌ Go API não está respondendo${NC}"
    exit 1
fi

if ! curl -s http://localhost:3000/primes?n=10 > /dev/null; then
    echo -e "${RED}❌ NestJS API não está respondendo${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Ambas aplicações rodando${NC}"
echo ""

# Configurações
REQUESTS_CPU=1000
CONCURRENCY_CPU=100
REQUESTS_IO=100
CONCURRENCY_IO=10
PRIMES_N=100000

# Criar pasta de resultados
RESULTS_DIR="benchmark-results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p "${RESULTS_DIR}/${TIMESTAMP}"

echo "Resultados em: ${RESULTS_DIR}/${TIMESTAMP}"
echo ""

# ═══════════════════════════════════════════════════════
# CPU-BOUND: PRIMES
# ═══════════════════════════════════════════════════════

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}🔢 CPU-BOUND: Primos (n=${PRIMES_N})${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Requests: ${REQUESTS_CPU} | Concurrency: ${CONCURRENCY_CPU}"
echo ""

echo -e "${YELLOW}▶ Go + Gin${NC}"
hey -n $REQUESTS_CPU -c $CONCURRENCY_CPU "http://localhost:8080/primes?n=${PRIMES_N}" | tee "${RESULTS_DIR}/${TIMESTAMP}/go-primes.txt"
echo ""

echo -e "${YELLOW}▶ NestJS${NC}"
hey -n $REQUESTS_CPU -c $CONCURRENCY_CPU "http://localhost:3000/primes?n=${PRIMES_N}" | tee "${RESULTS_DIR}/${TIMESTAMP}/nest-primes.txt"
echo ""

# ═══════════════════════════════════════════════════════
# I/O-BOUND: FETCH
# ═══════════════════════════════════════════════════════

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}🌐 I/O-BOUND: Fetch Simples${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Requests: ${REQUESTS_IO} | Concurrency: ${CONCURRENCY_IO}"
echo ""

echo -e "${YELLOW}▶ Go + Gin${NC}"
hey -n $REQUESTS_IO -c $CONCURRENCY_IO "http://localhost:8080/fetch" | tee "${RESULTS_DIR}/${TIMESTAMP}/go-fetch.txt"
echo ""

echo -e "${YELLOW}▶ NestJS${NC}"
hey -n $REQUESTS_IO -c $CONCURRENCY_IO "http://localhost:3000/fetch" | tee "${RESULTS_DIR}/${TIMESTAMP}/nest-fetch.txt"
echo ""

# ═══════════════════════════════════════════════════════
# I/O-BOUND: AGGREGATE
# ═══════════════════════════════════════════════════════

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}🔄 I/O-BOUND: Aggregate (10 paralelas)${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Requests: ${REQUESTS_IO} | Concurrency: ${CONCURRENCY_IO}"
echo ""

echo -e "${YELLOW}▶ Go + Gin${NC}"
hey -n $REQUESTS_IO -c $CONCURRENCY_IO "http://localhost:8080/aggregate" | tee "${RESULTS_DIR}/${TIMESTAMP}/go-aggregate.txt"
echo ""

echo -e "${YELLOW}▶ NestJS${NC}"
hey -n $REQUESTS_IO -c $CONCURRENCY_IO "http://localhost:3000/aggregate" | tee "${RESULTS_DIR}/${TIMESTAMP}/nest-aggregate.txt"
echo ""

# ═══════════════════════════════════════════════════════
# RESUMO
# ═══════════════════════════════════════════════════════

echo "═══════════════════════════════════════════════════════"
echo -e "${GREEN}✅ Benchmark Concluído!${NC}"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "📁 Resultados salvos em: ${RESULTS_DIR}/${TIMESTAMP}/"
echo ""

# Extrai métricas principais
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}📊 RESUMO RÁPIDO${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

extract_rps() {
    grep "Requests/sec:" "$1" 2>/dev/null | awk '{print $2}'
}

extract_avg() {
    grep "Average:" "$1" 2>/dev/null | awk '{print $2}'
}

echo "🔢 CPU-Bound (Primos n=${PRIMES_N}):"
GO_RPS=$(extract_rps "${RESULTS_DIR}/${TIMESTAMP}/go-primes.txt")
NEST_RPS=$(extract_rps "${RESULTS_DIR}/${TIMESTAMP}/nest-primes.txt")
GO_AVG=$(extract_avg "${RESULTS_DIR}/${TIMESTAMP}/go-primes.txt")
NEST_AVG=$(extract_avg "${RESULTS_DIR}/${TIMESTAMP}/nest-primes.txt")

echo "  Go:     ${GO_RPS:-N/A} req/s | Avg: ${GO_AVG:-N/A}"
echo "  NestJS: ${NEST_RPS:-N/A} req/s | Avg: ${NEST_AVG:-N/A}"
echo ""

echo "🌐 I/O-Bound (Fetch):"
GO_FETCH_RPS=$(extract_rps "${RESULTS_DIR}/${TIMESTAMP}/go-fetch.txt")
NEST_FETCH_RPS=$(extract_rps "${RESULTS_DIR}/${TIMESTAMP}/nest-fetch.txt")
echo "  Go:     ${GO_FETCH_RPS:-N/A} req/s"
echo "  NestJS: ${NEST_FETCH_RPS:-N/A} req/s"
echo ""

echo "🔄 I/O-Bound (Aggregate):"
GO_AGG_RPS=$(extract_rps "${RESULTS_DIR}/${TIMESTAMP}/go-aggregate.txt")
NEST_AGG_RPS=$(extract_rps "${RESULTS_DIR}/${TIMESTAMP}/nest-aggregate.txt")
echo "  Go:     ${GO_AGG_RPS:-N/A} req/s"
echo "  NestJS: ${NEST_AGG_RPS:-N/A} req/s"
echo ""

echo "═══════════════════════════════════════════════════════"
echo ""