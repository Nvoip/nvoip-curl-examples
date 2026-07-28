#!/bin/sh
set -eu

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"
: "${NVOIP_ACCESS_TOKEN:?Missing NVOIP_ACCESS_TOKEN}"
: "${NVOIP_WA_TEMPLATE_ID:?Missing NVOIP_WA_TEMPLATE_ID}"
: "${NVOIP_WA_INSTANCE:?Missing NVOIP_WA_INSTANCE}"
: "${NVOIP_WA_LANGUAGE:?Missing NVOIP_WA_LANGUAGE}"

BODY_VARIABLES="${NVOIP_WA_BODY_VARIABLES:-[]}"
HEADER_VARIABLES="${NVOIP_WA_HEADER_VARIABLES:-[]}"
TO_FLOW="${NVOIP_WA_TO_FLOW:-false}"
RECIPIENT_TYPE="${NVOIP_WA_RECIPIENT_TYPE:-}"
RECIPIENT_VALUE="${NVOIP_WA_RECIPIENT_VALUE:-}"

if [ -n "$RECIPIENT_TYPE" ]; then
  case "$RECIPIENT_TYPE" in phone|bsuid|parent_bsuid) ;; *)
    echo "NVOIP_WA_RECIPIENT_TYPE must be phone, bsuid or parent_bsuid" >&2
    exit 1
  esac
  [ -n "$RECIPIENT_VALUE" ] || {
    echo "NVOIP_WA_RECIPIENT_VALUE is required with NVOIP_WA_RECIPIENT_TYPE" >&2
    exit 1
  }
  case "$RECIPIENT_VALUE" in @*)
    echo "@username is not a WhatsApp recipient; use a BSUID or parent BSUID" >&2
    exit 1
  esac
  if [ "$RECIPIENT_TYPE" = "phone" ]; then
    PHONE_DIGITS="${RECIPIENT_VALUE#+}"
    case "$PHONE_DIGITS" in ''|*[!0-9]*)
      echo "A phone recipient must contain only an optional leading + and 8 to 20 digits" >&2
      exit 1
    esac
    [ "${#PHONE_DIGITS}" -ge 8 ] && [ "${#PHONE_DIGITS}" -le 20 ] || {
      echo "A phone recipient must contain 8 to 20 digits" >&2
      exit 1
    }
  else
    case "$RECIPIENT_VALUE" in *[[:space:]]*)
      echo "A BSUID must be an opaque value without whitespace" >&2
      exit 1
    esac
    [ "${#RECIPIENT_VALUE}" -le 256 ] || {
      echo "A BSUID must have at most 256 characters" >&2
      exit 1
    }
  fi
  case "$RECIPIENT_TYPE:$TO_FLOW" in bsuid:true|parent_bsuid:true)
    echo "WhatsApp Flow and attendance require a phone recipient" >&2
    exit 1
  esac
  RECIPIENT_JSON="\"recipient\":{\"type\":\"$RECIPIENT_TYPE\",\"value\":\"$RECIPIENT_VALUE\"}"
else
  : "${NVOIP_WA_DESTINATION:?Missing NVOIP_WA_DESTINATION; use NVOIP_WA_RECIPIENT_TYPE and NVOIP_WA_RECIPIENT_VALUE for BSUID}"
  PHONE_DIGITS="${NVOIP_WA_DESTINATION#+}"
  case "$PHONE_DIGITS" in ''|*[!0-9]*)
    echo "NVOIP_WA_DESTINATION must be a phone number; use recipient for BSUID" >&2
    exit 1
  esac
  [ "${#PHONE_DIGITS}" -ge 8 ] && [ "${#PHONE_DIGITS}" -le 20 ] || {
    echo "NVOIP_WA_DESTINATION must contain 8 to 20 digits" >&2
    exit 1
  }
  RECIPIENT_JSON="\"destination\":\"$NVOIP_WA_DESTINATION\""
fi

curl -sS \
  --request POST \
  --header "Authorization: Bearer $NVOIP_ACCESS_TOKEN" \
  --header "Content-Type: application/json" \
  --data-binary "{
    \"idTemplate\": \"$NVOIP_WA_TEMPLATE_ID\",
    $RECIPIENT_JSON,
    \"instance\": \"$NVOIP_WA_INSTANCE\",
    \"language\": \"$NVOIP_WA_LANGUAGE\",
    \"bodyVariables\": $BODY_VARIABLES,
    \"headerVariables\": $HEADER_VARIABLES,
    \"functions\": {
      \"to_flow\": $TO_FLOW
    }
  }" \
  "$NVOIP_BASE_URL/wa/sendTemplates"
