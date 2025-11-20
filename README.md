# Streetrace Docker

Docker container for running Streetrace AI agents with pre-configured Python and Node.js environments.

## Quick Start

### Using Docker Compose

1. Clone the repository:
```bash
git clone https://github.com/streetrace-ai/streetrace-ai-docker.git
cd streetrace-ai-docker
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
```

4. Run the container:
```bash
docker-compose up
```

### Using Docker CLI

Run the container:
```bash
docker run --env-file .env streetrace/streetrace:latest
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
STREETRACE_API_KEY="dnav233GFXgdfhg"
AGENT="my_agent"
PROMPT="Analyze this codebase and provide suggestions"
```

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