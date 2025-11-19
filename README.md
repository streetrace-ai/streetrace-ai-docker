# Streetrace Docker

Docker container for running Streetrace AI agents with pre-configured Python and Node.js environments.

## Quick Start

### Using Docker Compose (Recommended)

1. Clone the repository:
```bash
git clone https://github.com/streetrace-ai/streetrace-docker.git
cd streetrace-docker
```

2. Copy the environment file:
```bash
cp .env.example .env
```

3. Configure your environment variables in `.env`:
```bash
STREETRACE_API_KEY="your_api_key_here"
AGENT="your_agent_id_here"
PROMPT="your_user_prompt_here"
DEBUG=1
```

4. Run the container:
```bash
docker-compose up
```

### Using Docker CLI

1. Pull the pre-built image:
```bash
docker pull streetrace/streetrace:latest
```

2. Run the container:
```bash
docker run --env-file .env -v $(pwd):/streetrace streetrace/streetrace:latest
```

### Building Locally

```bash
docker build -t streetrace-agent .
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

### Example .env Configuration

```bash
STREETRACE_API_KEY="your_api_key_here"
DEBUG=1
AGENT="your_agent_id_here"
PROMPT="Analyze this codebase and provide suggestions"
```

## Container Features

- **Python 3.13-slim** base image with uv package manager
- **Node.js 24** installed via nvm
- **Streetrace CLI** pre-installed from GitHub
- **OpenTelemetry** tracing automatically configured
- **Git** and essential build tools included
- Volume mounting for local development at `/streetrace`

## Architecture

The container uses a custom entrypoint script that:
- Configures OpenTelemetry tracing with your API key
- Constructs the agent URL from `STREETRACE_API_URL` and `AGENT` ID
- Enables verbose logging when `DEBUG=1`
- Executes the Streetrace CLI with your specified prompt

## CI/CD

The repository includes GitHub Actions workflow that:
- Builds multi-platform images (linux/amd64, linux/arm64)
- Pushes to Docker Hub as `streetrace/streetrace:latest`
- Triggers on changes to Dockerfile, entrypoint.sh, or docker-compose.yml

## Development

### Running with SSH Access

```bash
docker run -it --env-file .env \
  -v $(pwd):/streetrace \
  -v ~/.ssh:/root/.ssh:ro \
  streetrace/streetrace:latest
```

### Interactive Shell

```bash
docker run -it --env-file .env \
  -v $(pwd):/streetrace \
  --entrypoint bash \
  streetrace/streetrace:latest
```

## Troubleshooting

- **Authentication errors**: Verify your `STREETRACE_API_KEY` is correct
- **Agent not found**: Check that `AGENT` exists and is accessible
- **Network issues**: Ensure `STREETRACE_API_URL` is reachable
- **Debug mode**: Set `DEBUG=1` for verbose output