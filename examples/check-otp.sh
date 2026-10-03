#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v3}"
: "${NVOIP_OTP_KEY:?Missing NVOIP_OTP_KEY}"
: "${NVOIP_OTP_CODE:?Missing NVOIP_OTP_CODE}"

: "${NVOIP_ACCESS_TOKEN:?Missing NVOIP_ACCESS_TOKEN}"

curl --fail-with-body -sS --get \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  --data-urlencode "code=$NVOIP_OTP_CODE" \
  --data-urlencode "key=$NVOIP_OTP_KEY" \
  "$NVOIP_BASE_URL/check/otp"
