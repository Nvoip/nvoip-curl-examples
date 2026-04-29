#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"
: "${NVOIP_ACCESS_TOKEN:?Missing NVOIP_ACCESS_TOKEN}"
: "${NVOIP_OTP_SMS:?Missing NVOIP_OTP_SMS}"

curl -sS \
  --request POST \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  --header "Content-Type: application/json" \
  --data-binary "{
    \"sms\": \"$NVOIP_OTP_SMS\"
  }" \
  "$NVOIP_BASE_URL/otp"
