FROM python:3.14-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*


COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-dev

RUN if [ "$(uname -m)" = "aarch64" ]; then \
        curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-arm64 && \
        chmod +x tailwindcss-linux-arm64 && \
        mv tailwindcss-linux-arm64 /usr/local/bin/tailwindcss; \
    else \
        curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 && \
        chmod +x tailwindcss-linux-x64 && \
        mv tailwindcss-linux-x64 /usr/local/bin/tailwindcss; \
    fi

COPY . .

RUN curl -sLO https://github.com/saadeghi/daisyui/releases/latest/download/daisyui.mjs && \
    curl -sLO https://github.com/saadeghi/daisyui/releases/latest/download/daisyui-theme.mjs

RUN tailwindcss -i web/styles/input.css -o web/assets/css/output.css --minify

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000", "--ssl-keyfile=/etc/letsencrypt/live/web.vicolby.space/privkey.pem", "--ssl-certfile=/etc/letsencrypt/live/web.vicolby.space/fullchain.pem"]
