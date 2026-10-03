#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v3}"
: "${NVOIP_ACCESS_TOKEN:?Missing NVOIP_ACCESS_TOKEN}"
: "${NVOIP_OTP_PHONE:?Missing NVOIP_OTP_PHONE}"

curl --fail-with-body -sS \
  --request POST \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  --header "Content-Type: application/json" \
  --data-binary "{
    \"phoneNumber\": \"$NVOIP_OTP_PHONE\",
    \"methods\": {\"sms\": true}
  }" \
  "$NVOIP_BASE_URL/otp"
