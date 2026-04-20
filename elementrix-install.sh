#!/bin/bash

set -e

echo "🚀 Starting ELEMENTRIX Platform..."
echo ""

# Ensure external Docker network exists
NETWORK_NAME="elementrix"

if ! docker network inspect $NETWORK_NAME >/dev/null 2>&1; then
    echo "🌐 Creating Docker network: $NETWORK_NAME"
    docker network create $NETWORK_NAME
else
    echo "🌐 Docker network '$NETWORK_NAME' already exists."
fi

echo ""

# Start Docker Compose
docker compose -f services-docker-compose.yml \
               -f microservices-docker-compose.yml up -d

echo ""
echo "⏳ Containers are starting..."
sleep 3

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Detect server IP automatically
SERVER_IP=$(hostname -I | awk '{print $1}')

echo -e "${GREEN}"
echo "███████╗██╗     ███████╗███╗   ███╗███████╗███╗   ██╗████████╗██████╗ ██╗██╗  ██╗"
echo "██╔════╝██║     ██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝██╔══██╗██║╚██╗██╔╝"
echo "█████╗  ██║     █████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║   ██████╔╝██║ ╚███╔╝ "
echo "██╔══╝  ██║     ██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   ██╔══██╗██║ ██╔██╗ "
echo "███████╗███████╗███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   ██║  ██║██║██╔╝ ██╗"
echo "╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝"
echo -e "${NC}"
echo ""
echo -e "${GREEN}✅ ELEMENTRIX PLATFORM IS READY${NC}"
echo ""
echo "🌐 Access URL:"
echo "   http://$SERVER_IP:80"
echo ""
echo "📅 Started at: $(date)"
echo ""

echo -e "${YELLOW}------------------------------------------------------------${NC}"
echo -e "${YELLOW}⚖ LICENSE NOTICE${NC}"
echo ""
echo -e "${YELLOW}Please note: A valid license is required to operate${NC}"
echo -e "${YELLOW}the Elementrix Platform in production environments.${NC}"
echo ""
echo -e "${YELLOW}For licensing inquiries, please contact us.${NC}"
echo -e "${YELLOW}Visit: https://elementrix.io/elementrix/${NC}"
echo -e "${YELLOW}------------------------------------------------------------${NC}"
echo ""