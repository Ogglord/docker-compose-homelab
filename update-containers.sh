#!/usr/bin/env bash
echo "Updating docker-compose.yml containers..."
docker compose pull
docker compose up --force-recreate --build -d --remove-orphans
docker image prune -f
