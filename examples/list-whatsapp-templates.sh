#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"
: "${NVOIP_ACCESS_TOKEN:?Missing NVOIP_ACCESS_TOKEN}"

curl -sS \
  --request GET \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  "$NVOIP_BASE_URL/wa/listTemplates"
