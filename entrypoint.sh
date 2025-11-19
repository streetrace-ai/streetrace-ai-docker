#!/bin/bash
set -e

export STREETRACE_API_URL="${STREETRACE_API_URL:-https://api.streetrace.ai}"
export OTEL_EXPORTER_OTLP_ENDPOINT="${STREETRACE_API_URL}/api/public/otel/v1/traces"
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=${STREETRACE_API_KEY}"

# Add verbose flag if DEBUG is set
VERBOSE_FLAG=""
if [ "$DEBUG" = "true" ] || [ "$DEBUG" = "1" ]; then
    VERBOSE_FLAG="--verbose"
fi

streetrace --agent="${STREETRACE_API_URL}/api/public/agents/${AGENT_ID}" --prompt="${PROMPT}" $VERBOSE_FLAG