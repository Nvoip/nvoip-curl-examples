#!/bin/sh
set -eu

nvoip_require_var() {
  var_name="$1"
  eval "var_value=\${$var_name:-}"
  if [ -z "$var_value" ]; then
    printf 'Missing required variable: %s\n' "$var_name" >&2
    exit 1
  fi
}

nvoip_require_var NVOIP_ACCESS_TOKEN

curl -sS \
  --request GET \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  "${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}/balance"
