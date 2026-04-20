#!/bin/bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

COMPOSE_FILES=(
  -f services-docker-compose.yml
  -f microservices-docker-compose.yml
)

echo -e "${YELLOW}"
echo "⚠ WARNING: This will remove only Elementrix containers, networks,"
echo "and named volumes defined in the Elementrix compose files."
echo "Docker itself and unrelated containers/images/volumes will not be removed."
echo -e "${NC}"

read -r -p "Are you sure you want to continue? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
    echo "Operation cancelled."
    exit 0
fi

echo
echo "🛑 Stopping and removing Elementrix platform..."
docker compose "${COMPOSE_FILES[@]}" down -v --remove-orphans

echo
echo "🧹 Removing Elementrix images only..."

# Get image names referenced by the compose stack
mapfile -t ELEMENTRIX_IMAGES < <(docker compose "${COMPOSE_FILES[@]}" config | awk '/image:/ {print $2}' | sort -u)

if [[ ${#ELEMENTRIX_IMAGES[@]} -gt 0 ]]; then
    for img in "${ELEMENTRIX_IMAGES[@]}"; do
        if docker image inspect "$img" >/dev/null 2>&1; then
            echo "Removing image: $img"
            docker rmi "$img" || true
        fi
    done
else
    echo "No explicit images found in compose files."
fi

echo
echo "🧽 Removing Elementrix build cache leftovers if any..."
docker builder prune -f >/dev/null 2>&1 || true

echo
sleep 1

echo -e "${GREEN}✅ ELEMENTRIX PLATFORM HAS BEEN SUCCESSFULLY REMOVED${NC}"
echo
echo "🧹 Cleanup completed at: $(date)"