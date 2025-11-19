#!/bin/bash
set -e

STREETRACE_API_URL="${STREETRACE_API_URL:-https://api.streetrace.ai}"
PROMPT="${PROMPT:-"Hello from Streetrace!"}"
AGENT_PATH="${AGENT:-default}"

if [ "$LOCAL" != "true" ] || [ "$LOCAL" != "1" ]
    AGENT_PATH="${STREETRACE_API_URL}/api/public/agents/${AGENT}"
    # Set OpenTelemetry environment variables for OTLP exporter
    export OTEL_EXPORTER_OTLP_ENDPOINT="${STREETRACE_API_URL}/api/public/otel/v1/traces"
    export OTEL_EXPORTER_OTLP_HEADERS="Authorization=${STREETRACE_API_KEY}"
    export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"
fi

# Add verbose flag if DEBUG is set
VERBOSE_FLAG=""
if [ "$DEBUG" = "true" ] || [ "$DEBUG" = "1" ]; then
    VERBOSE_FLAG="--verbose"
fi

streetrace --agent=$AGENT_PATH --prompt="${PROMPT}" $VERBOSE_FLAG