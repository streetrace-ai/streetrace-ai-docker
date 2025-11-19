# streetrace.ai Docker image

Docker container for running Streetrace AI agents.

## Quick Start

### Using Docker Compose (Recommended)

1. Clone the repository:
```bash
git clone <repository-url>
cd streetrace-docker
```

2. Copy the environment file:
```bash
cp .env.example .env
```

3. Configure your environment variables in `.env` (see [Environment Variables](#environment-variables))

4. Run the container:
```bash
docker-compose up
```

### Using Docker CLI

1. Build the image:
```bash
docker build -t streetrace-agent .
```

2. Run the container:
```bash
docker run --env-file .env -v $(pwd):/streetrace streetrace-agent
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `STREETRACE_API_KEY` | ✅ | - | Your Streetrace API authentication key |
| `AGENT` | ✅ | - | The ID of the agent to run |
| `PROMPT` | ❌ | "Hello from Streetrace!" | The prompt/message to send to the agent |
| `DEBUG` | ❌ | `false` | Enable verbose logging (`1` or `true`) |
| `STREETRACE_API_URL` | ❌ | `https://api.streetrace.ai` | Streetrace API base URL |

### Example Configuration

```bash
STREETRACE_API_KEY="sk-1234567890abcdef"
DEBUG=1
AGENT="agent-abc123"
PROMPT="Analyze this codebase and provide suggestions"
```

## Container Features

- **Python 3.13** with uv package manager
- **Node.js 24** with nvm
- **Streetrace CLI** pre-installed
- **OpenTelemetry** tracing configured
- Volume mounting for local development

## Development

### Building Locally

```bash
docker build -t streetrace-agent:local .
```

### Running with Custom Volumes

```bash
docker run -it --env-file .env \
  -v $(pwd):/streetrace \
  -v ~/.ssh:/root/.ssh:ro \
  streetrace-agent:local
```

## Troubleshooting

- **Authentication errors**: Verify your `STREETRACE_API_KEY` is correct
- **Agent not found**: Check that `AGENT` exists and is accessible
- **Network issues**: Ensure `STREETRACE_API_URL` is reachable
- **Debug mode**: Set `DEBUG=1` for verbose output