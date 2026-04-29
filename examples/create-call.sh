#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"
: "${NVOIP_ACCESS_TOKEN:?Missing NVOIP_ACCESS_TOKEN}"
: "${NVOIP_CALLER:?Missing NVOIP_CALLER}"
: "${NVOIP_TARGET_NUMBER:?Missing NVOIP_TARGET_NUMBER}"

curl -sS \
  --request POST \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  --header "Content-Type: application/json" \
  --data-binary "{
    \"caller\": \"$NVOIP_CALLER\",
    \"called\": \"$NVOIP_TARGET_NUMBER\"
  }" \
  "$NVOIP_BASE_URL/calls/"
