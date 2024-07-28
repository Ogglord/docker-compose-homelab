## Homelab Setup in Docker Compose

### Screenshot

<img height="400" src="https://raw.githubusercontent.com/Ogglord/docker-compose-homelab/main/core-apps/resources/homepage.png" alt="Missing Screenshot" />

### Getting started

 1. Clone repo ```git clone https://github.com/Ogglord/docker-compose-homelab.git```
 2. Modify .env
 3. Start them using ```docker compose up -d```
 4. ```./update-config.sh```
 5. Re-start the relevant containers using ```docker compose up -d``` again
 6. Setup reverse proxies and SSL certificate in Nginx Proxy Manager
 7. Configure the containers, etc.
 8. Setup backups if you care about the state of things 

### Special features

TubeArchivist downloads youtube episodes for offline viewing, the channels can be browsed in Plex Media Server.

The Plex Media Server container automatically installs the TubeArchivist plug-in. Using a linuxserver.io Mod that I have written, named [plex-tubearchivist](https://github.com/Ogglord/plex-tubearchivist).
