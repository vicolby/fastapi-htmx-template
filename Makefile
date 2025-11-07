all: run test

install:
	@if [ -f tailwindcss ]; then \
		echo "tailwindcss already exists. Skipping download."; \
	else \
		echo "Installing Tailwind CSS standalone CLI..."; \
		if [ "$$(uname -s)" = "Darwin" ]; then \
			if [ "$$(uname -m)" = "arm64" ]; then \
				curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64; \
				chmod +x tailwindcss-macos-arm64; \
				mv tailwindcss-macos-arm64 tailwindcss; \
			else \
				curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-x64; \
				chmod +x tailwindcss-macos-x64; \
				mv tailwindcss-macos-x64 tailwindcss; \
			fi \
		elif [ "$$(uname -s)" = "Linux" ]; then \
			if [ "$$(uname -m)" = "aarch64" ]; then \
				curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-arm64; \
				chmod +x tailwindcss-linux-arm64; \
				mv tailwindcss-linux-arm64 tailwindcss; \
			else \
				curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64; \
				chmod +x tailwindcss-linux-x64; \
				mv tailwindcss-linux-x64 tailwindcss; \
			fi \
		else \
			echo "Unsupported platform. Please download tailwindcss manually from https://github.com/tailwindlabs/tailwindcss/releases/latest"; \
			exit 1; \
		fi; \
		echo "Tailwind CSS installed successfully!"; \
	fi
	@if [ -f daisyui.mjs ] && [ -f daisyui-theme.mjs ]; then \
		echo "DaisyUI files already exist. Skipping download."; \
	else \
		echo "Downloading DaisyUI files..."; \
		curl -sLO https://github.com/saadeghi/daisyui/releases/latest/download/daisyui.mjs; \
		curl -sLO https://github.com/saadeghi/daisyui/releases/latest/download/daisyui-theme.mjs; \
		echo "DaisyUI files downloaded successfully!"; \
	fi


tailwind:
	@echo "Starting Tailwind CSS in watch mode..."
	@./tailwindcss -i web/styles/input.css -o web/assets/css/output.css --watch

server:
	@echo "Starting FastAPI server..."
	@uv run uvicorn src.main:app --reload

run:
	@echo "Run 'make tailwind' in one terminal and 'make server' in another"
