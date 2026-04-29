#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"
: "${NVOIP_ACCESS_TOKEN:?Missing NVOIP_ACCESS_TOKEN}"
: "${NVOIP_WA_TEMPLATE_ID:?Missing NVOIP_WA_TEMPLATE_ID}"
: "${NVOIP_WA_DESTINATION:?Missing NVOIP_WA_DESTINATION}"
: "${NVOIP_WA_INSTANCE:?Missing NVOIP_WA_INSTANCE}"
: "${NVOIP_WA_LANGUAGE:?Missing NVOIP_WA_LANGUAGE}"

BODY_VARIABLES="${NVOIP_WA_BODY_VARIABLES:-[]}"
HEADER_VARIABLES="${NVOIP_WA_HEADER_VARIABLES:-[]}"
TO_FLOW="${NVOIP_WA_TO_FLOW:-false}"

curl -sS \
  --request POST \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  --header "Content-Type: application/json" \
  --data-binary "{
    \"idTemplate\": \"$NVOIP_WA_TEMPLATE_ID\",
    \"destination\": \"$NVOIP_WA_DESTINATION\",
    \"instance\": \"$NVOIP_WA_INSTANCE\",
    \"language\": \"$NVOIP_WA_LANGUAGE\",
    \"bodyVariables\": $BODY_VARIABLES,
    \"headerVariables\": $HEADER_VARIABLES,
    \"functions\": {
      \"to_flow\": $TO_FLOW
    }
  }" \
  "$NVOIP_BASE_URL/wa/sendTemplates"
