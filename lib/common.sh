#!/bin/sh

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"

nvoip_require_var() {
  var_name="$1"
  eval "var_value=\${$var_name:-}"
  if [ -z "$var_value" ]; then
    printf 'Missing required variable: %s\n' "$var_name" >&2
    return 1
  fi
}

nvoip_encode_basic_auth() {
  printf '%s' "$1:$2" | base64 | tr -d '\n'
}

nvoip_resolve_basic_auth() {
  nvoip_require_var NVOIP_OAUTH_CLIENT_ID || return 1
  nvoip_require_var NVOIP_OAUTH_CLIENT_SECRET || return 1
  nvoip_encode_basic_auth "$NVOIP_OAUTH_CLIENT_ID" "$NVOIP_OAUTH_CLIENT_SECRET"
}

nvoip_create_access_token() {
  nvoip_require_var NVOIP_NUMBERSIP || return 1
  nvoip_require_var NVOIP_USER_TOKEN || return 1
  basic_auth="$(nvoip_resolve_basic_auth)" || return 1

  curl -sS \
    --request POST \
    --header "Authorization: Basic $basic_auth" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --data "username=$NVOIP_NUMBERSIP&password=$NVOIP_USER_TOKEN&grant_type=password" \
    "$NVOIP_BASE_URL/oauth/token"
}
