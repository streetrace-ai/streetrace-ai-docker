FROM python:3.13-slim-bookworm

WORKDIR /app

ARG NODE_VERSION=20

# install curl, GIT and ca-certificates
RUN apt update && apt install -y curl ca-certificates git

# install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# set env
ENV NVM_DIR=/root/.nvm
ENV OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"

# install Node
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION"

# set ENTRYPOINT for reloading nvm-environment
ENTRYPOINT ["bash", "-c", "source $NVM_DIR/nvm.sh && exec \"$@\"", "--"]

# install uv
# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

# Install Streetrace
RUN uv tool install git+https://github.com/streetrace-ai/streetrace.git

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]