#!/usr/bin/env bash
set -euo pipefail

ARCHIVO="data/raw/ventas.csv"
SALIDA="data/clean/reporte_ciudades.csv"

if [[ ! -f "$ARCHIVO" ]]; then
    echo "ERROR: no existe $ARCHIVO" >&2
    exit 1
fi

mkdir -p data/clean
echo "ciudad,pedidos,total" > "$SALIDA"

for CIUDAD in $(tail -n +2 "$ARCHIVO" | cut -d, -f4 | sort -u); do
    PEDIDOS=$(awk -F, -v c="$CIUDAD" '$4==c' "$ARCHIVO" | wc -l)
    TOTAL=$(awk -F, -v c="$CIUDAD" '$4==c {s+=$7} END {print s+0}' "$ARCHIVO")
    echo "$CIUDAD,$PEDIDOS,$TOTAL" >> "$SALIDA"
done

echo "Reporte generado en $SALIDA"
