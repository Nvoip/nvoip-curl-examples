#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"
: "${NVOIP_OTP_KEY:?Missing NVOIP_OTP_KEY}"
: "${NVOIP_OTP_CODE:?Missing NVOIP_OTP_CODE}"

curl -sS \
  --request GET \
  "$NVOIP_BASE_URL/check/otp?code=$NVOIP_OTP_CODE&key=$NVOIP_OTP_KEY"
