#!/usr/bin/env bash
set -euo pipefail
CIUDAD="${1:?Uso: ./scripts/resumen.sh <ciudad>}"
ARCHIVO="data/raw/ventas.csv"
PEDIDOS=$(awk -F, -v c="$CIUDAD" '$4==c' "$ARCHIVO" | wc -l)
TOTAL=$(awk -F, -v c="$CIUDAD" '$4==c {s+=$7} END {print s+0}' "$ARCHIVO")
PROMEDIO=$(awk -v t="$TOTAL" -v p="$PEDIDOS" 'BEGIN {print t/p}')
echo "Ciudad: $CIUDAD"
echo "Pedidos: $PEDIDOS"
echo "Total ventas: $TOTAL"
echo "Promedio por pedidos: $PROMEDIO"
