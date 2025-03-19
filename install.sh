#!/bin/sh

set -e  # Exit on error
set -u  # Treat unset variables as an error


# Ensure desktop file directory exists
COMPOSE_URL="https://gitlab.com/gnukhata/build/-/raw/master/docker-compose.yml"
APPLICATION_DIR="$HOME/.local/share/applications"
PROJECT_DIR="$HOME/.local/share/gnukhata"
CONF_DIR="$HOME/.config/gnukhata"
CONF_FILE=${1:-}
DOCKER_COMPOSE_COMMAND=""

# To cleanup on error
cleanup() {
    echo "Cleaning up..."
    cd ..
    rm -rf "$PROJECT_DIR" "$CONF_DIR"
}

trap cleanup EXIT

# Check if docker compose is available
if [ -x "$(command -v docker-compose)" ]; then
    echo "SUCCESS: docker-compose is installed."
    DOCKER_COMPOSE_COMMAND="docker-compose"
elif $(docker compose &>/dev/null) && [ $? -eq 0 ]; then
    echo "SUCCESS: docker compose is installed."
    DOCKER_COMPOSE_COMMAND="docker compose"
else
    echo "ERROR: Docker Compose is not installed or not in PATH. Please install Docker Compose before running this script."
    exit 1
fi

# Create application directory
if [ ! -d "$APPLICATION_DIR" ]; then
    mkdir -p "$APPLICATION_DIR"
fi

# Create project directory
if [ ! -d "$PROJECT_DIR" ]; then
    mkdir -p "$PROJECT_DIR"
fi

# Copy conf file
if [ -f "$CONF_FILE" ]; then
    mkdir -p "$CONF_DIR"
    cp "$CONF_FILE" "$CONF_DIR/env"
fi

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

# Save docker compose function as an executable script
RUN_SCRIPT="$PROJECT_DIR/run_docker_compose.sh"
echo '#!/bin/sh' > "$RUN_SCRIPT"
echo "cd $PROJECT_DIR" >> "$RUN_SCRIPT"
echo "if [ -f \"$CONF_DIR/env\" ]; then" >> "$RUN_SCRIPT"
echo "  $DOCKER_COMPOSE_COMMAND --profile frontend --env-file \"$CONF_DIR/env\" up -d" >> "$RUN_SCRIPT"
echo "else" >> "$RUN_SCRIPT"
echo "  $DOCKER_COMPOSE_COMMAND --profile frontend up -d" >> "$RUN_SCRIPT"
echo "fi" >> "$RUN_SCRIPT"
chmod +x "$RUN_SCRIPT"

sh "$RUN_SCRIPT"

# Disable cleanup on successful execution
trap - EXIT

echo "Docker Compose setup completed successfully."

# Create a desktop entry for launching the setup
DESKTOP_FILE="$APPLICATION_DIR/gnukhata.desktop"
echo "[Desktop Entry]" > "$DESKTOP_FILE"
echo "Type=Application" >> "$DESKTOP_FILE"
echo "Terminal=true" >> "$DESKTOP_FILE"
echo "Exec=sh $RUN_SCRIPT" >> "$DESKTOP_FILE"
echo "Name=GNUKhata" >> "$DESKTOP_FILE"
echo "Comment=Launch the GNUKhata in a terminal" >> "$DESKTOP_FILE"
echo "[Desktop Action update-gnukhata]" >> "$DESKTOP_FILE"
echo "Name=Update" >> "$DESKTOP_FILE"
echo "Exec=sh -c 'curl -fsSL \"$COMPOSE_URL\" -o \"$COMPOSE_FILE\"'" >> "$DESKTOP_FILE"
echo "[Desktop Action close-gnukhata]" >> "$DESKTOP_FILE"
echo "Name=Close" >> "$DESKTOP_FILE"
echo "Exec=sh -c 'cd \"$PROJECT_DIR\" && $DOCKER_COMPOSE_COMMAND down --profile frontend'" >> "$DESKTOP_FILE"
chmod +x "$DESKTOP_FILE"

echo "Desktop launcher created at $DESKTOP_FILE"
