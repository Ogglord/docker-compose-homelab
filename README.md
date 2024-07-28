## Homelab Setup in Docker Compose

### Screenshot

<img src="https://raw.githubusercontent.com/Ogglord/docker-compose-homelab/main/pvr-apps/resources/homepage.png" alt="Missing Screenshot" />

### Getting started

 1. Clone repo ```git clone https://github.com/Ogglord/docker-compose-homelab.git```
 2. Modify .env
 3. Start them using ```docker compose up -d```
 4. ```./update-config.sh```
 5. Re-start the relevant containers using ```docker compose up -d``` again
 6. Setup reverse proxies and SSL certificate in Nginx Proxy Manager
 7. Configure the containers 1 by 1
 8. Make a full backup ;)

### Special features

The plex container automatically installs the TubeArchivist plug-in. Using the hook that linuxserver.io provides, it is described [here](https://docs.linuxserver.io/general/container-customization/).
