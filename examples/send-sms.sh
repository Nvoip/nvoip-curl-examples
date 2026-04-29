#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"
: "${NVOIP_ACCESS_TOKEN:?Missing NVOIP_ACCESS_TOKEN}"
: "${NVOIP_TARGET_NUMBER:?Missing NVOIP_TARGET_NUMBER}"
: "${NVOIP_SMS_MESSAGE:?Missing NVOIP_SMS_MESSAGE}"

curl -sS \
  --request POST \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  --header "Content-Type: application/json" \
  --data-binary "{
    \"numberPhone\": \"$NVOIP_TARGET_NUMBER\",
    \"message\": \"$NVOIP_SMS_MESSAGE\",
    \"flashSms\": false
  }" \
  "$NVOIP_BASE_URL/sms"
