#!/usr/bin/env bash
echo "Updating docker images..."

update(){
    ln -s ../.env .env
    echo "Updating $PWD"
    docker compose pull
    docker compose up --build -d --remove-orphans
    docker image prune -f
}

cd immich-app
update
cd ../pvr-apps
update
cd ../core-apps
update