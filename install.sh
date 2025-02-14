#!/bin/sh

set -e  # Exit on error
set -u  # Treat unset variables as an error

COMPOSE_URL="https://gitlab.com/gnukhata/build/-/raw/6a817be1991d141347bc1443b23aadf50d1cf5f8/docker-compose.yml"
PROJECT_DIR="gnukhata"
ENV_FILE=${1:-}

# To cleanup on error
cleanup() {
    echo "Cleaning up..."
    cd ..
    rm -rf "$PROJECT_DIR"
}

# Check if project directory already exists
if [ -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory '$PROJECT_DIR' already exists. Exiting."
    exit 1
fi

trap cleanup EXIT

# Check if docker compose is available
if ! command -v docker-compose >/dev/null 2>&1; then
    echo "Error: docker-compose is not installed or not in PATH. Please install Docker docker-compose running this script."
    exit 1
fi

# Create project directory
mkdir -p "$PROJECT_DIR"

# Download docker-compose file with retry mechanism
COMPOSE_FILE="$PROJECT_DIR/docker-compose.yml"
RETRIES=3
i=1
while [ $i -le $RETRIES ]; do
    if curl -fsSL "$COMPOSE_URL" -o "$COMPOSE_FILE"; then
        break
    else
        echo "Attempt $i failed, retrying..."
        sleep 2
    fi
    i=$((i + 1))
done

if [ ! -s "$COMPOSE_FILE" ]; then
    echo "Failed to download docker-compose file after $RETRIES attempts. Exiting."
    exit 1
fi

# Change to project directory
cd "$PROJECT_DIR"

echo "$ENV_FILE"

# Run docker compose
if [ -n "$ENV_FILE" ] && [ -f "$ENV_FILE" ]; then
    sudo docker-compose --profile frontend --env-file "$ENV_FILE" up -d
else
    sudo docker-compose --profile frontend up -d
fi

# Disable cleanup on successful execution
trap - EXIT

echo "Docker Compose setup completed successfully."

# Ensure desktop file directory exists
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"

# Create a desktop entry for launching the setup
DESKTOP_FILE="$DESKTOP_DIR/project-setup.desktop"
echo "[Desktop Entry]" > "$DESKTOP_FILE"
echo "Type=Application" >> "$DESKTOP_FILE"
echo "Terminal=true" >> "$DESKTOP_FILE"
echo "Exec=sh -c 'cd $PROJECT_DIR && docker compose up -d; exec $SHELL'" >> "$DESKTOP_FILE"
echo "Name=Project Setup" >> "$DESKTOP_FILE"
echo "Comment=Launch the project setup in a terminal" >> "$DESKTOP_FILE"
chmod +x "$DESKTOP_FILE"

echo "Desktop launcher created at $DESKTOP_FILE"

# Create a desktop entry for updating the project
UPDATE_FILE="$DESKTOP_DIR/project-update.desktop"
echo "[Desktop Entry]" > "$UPDATE_FILE"
echo "Type=Application" >> "$UPDATE_FILE"
echo "Terminal=true" >> "$UPDATE_FILE"
echo "Exec=sh -c 'cd $PROJECT_DIR && docker compose down && curl -fsSL $COMPOSE_URL -o $COMPOSE_FILE && docker compose up -d; exec $SHELL'" >> "$UPDATE_FILE"
echo "Name=Project Update" >> "$UPDATE_FILE"
echo "Comment=Update and restart the project" >> "$UPDATE_FILE"
chmod +x "$UPDATE_FILE"

echo "Update launcher created at $UPDATE_FILE"
