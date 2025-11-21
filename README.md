# Streetrace Docker

Docker container for running Streetrace AI Agents.

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
# Configure access to model provider
# OpenAI
OPENAI_API_KEY="your-api-key"
# Anthropic
ANTHROPIC_API_KEY="your-api-key"
# Google
GEMINI_API_KEY="your-api-key"

STREETRACE_API_KEY="your_api_key_here"
STREETRACE_AGENT_ID="your_agent_id_here"
STREETRACE_PROMPT="your_user_prompt_here"
```

4. Run the container:
```bash
docker-compose up
```

### Using Docker CLI

Fast run the container:
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
| `STREETRACE_AGENT_ID` | ✅ | - | The ID of the agent to run |
| `STREETRACE_PROMPT` | ❌ | - | The prompt/message to send to the agent |
| `DEBUG` | ❌ | `false` | Enable verbose logging (`1` or `true`) |
| `STREETRACE_API_URL` | ❌ | `https://api.streetrace.ai` | Streetrace API base URL |

## Model Configuration

Streetrace uses [LiteLLM](https://docs.litellm.ai/docs/providers) for model access. Set up your environment based on your chosen provider:

For detailed backend configuration including Azure, Vertex AI, and other providers, see [Backend Configuration Guide](docs/user/backend-configuration.md).

**Cloud Model Providers:**
```bash
# OpenAI
export OPENAI_API_KEY="your-api-key"

# Anthropic
export ANTHROPIC_API_KEY="your-api-key"

# Google
export GEMINI_API_KEY="your-api-key"

# AWS Bedrock
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_REGION="us-east-1"
```

**Local Models:**
```bash
# Ollama
export OLLAMA_API_URL="http://localhost:11434"

# Local OpenAI-compatible server
export OPENAI_API_BASE="http://localhost:8000/v1"
```

### Example .env Configuration

```bash
STREETRACE_API_KEY="dnav233GFXgdfhg"
STREETRACE_AGENT_ID="my_agent"
STREETRACE_PROMPT="Analyze this codebase and provide suggestions"
```

> **Quoting `.env` values**  
> The entrypoint strips a single leading and trailing quote from every variable, so both quoted and unquoted assignments behave the same (`STREETRACE_AGENT_ID=my-agent` and `STREETRACE_AGENT_ID="my-agent"` are equivalent). Keep quotes only when you need spaces in values such as `STREETRACE_PROMPT`, and avoid mixing unmatched quotes since they will be removed.

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
- **Agent not found**: Check that `STREETRACE_AGENT_ID` exists and is accessible
- **Network issues**: Ensure `STREETRACE_API_URL` is reachable
- **Debug mode**: Set `DEBUG=1` for verbose output
