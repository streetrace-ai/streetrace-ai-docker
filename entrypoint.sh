#!/bin/bash
set -e

strip_quotes() {
    local value="$1"
    value="${value%\"}"
    value="${value#\"}"
    value="${value%\'}"
    value="${value#\'}"
    printf '%s' "$value"
}

STREETRACE_API_URL="$(strip_quotes "${STREETRACE_API_URL:-https://api.streetrace.ai}")"
PROMPT="$(strip_quotes "${PROMPT:-Hello from Streetrace!}")"
AGENT="$(strip_quotes "${AGENT}")"
STREETRACE_API_KEY="$(strip_quotes "${STREETRACE_API_KEY}")"
DEBUG="$(strip_quotes "${DEBUG}")"
AGENT_PATH="${STREETRACE_API_URL}/api/public/agents/${AGENT}"

# Add verbose flag if DEBUG is set
VERBOSE_FLAG=""
if [ "$DEBUG" = "true" ] || [ "$DEBUG" = "1" ]; then
    VERBOSE_FLAG="--verbose"
fi

# Set OpenTelemetry environment variables for OTLP exporter
export OTEL_EXPORTER_OTLP_ENDPOINT="${STREETRACE_API_URL}/api/public/otel/v1/traces"
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=${STREETRACE_API_KEY}"
export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"

streetrace --agent="$AGENT_PATH" --prompt="$PROMPT" $VERBOSE_FLAG
