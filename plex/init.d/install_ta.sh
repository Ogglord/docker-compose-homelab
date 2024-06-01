#!/bin/bash

##############################
# AUTHOR: github.com/Ogglord
##############################

DL_URL="https://github.com/tubearchivist/tubearchivist-plex/archive/refs/heads/main.zip"

echo "TA: Tube Archivist script plugin installation for Plex begins..."
# Check for required environment variables
if [ -z "$TA_API_KEY" ]; then
    echo "TA: ERROR: Need to set TA_API_KEY!"
    exit 1
fi

if [ -z "$TA_URL" ]; then
    echo "TA: ERROR: Need to set TA_URL!"
    exit 1
fi

#PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support"
if [ -z "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR" ]; then
    echo "TA: ERROR: Need to set PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR!"
    exit 1
fi

PMS_DIR="${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"
if [ ! -d "$PMS_DIR" ]; then
  echo "TA: ERROR: $PMS_DIR does not exist!"
  exit 1
fi

## install unzip
if ! command -v unzip &> /dev/null
then
    apt update && apt install unzip
fi

cd /tmp

#Cleanup
rm -rf TubeArchivist-Agent.bundle/
rm -rf ta.zip
rm -rf "$PMS_DIR/Plug-ins/TubeArchivist-Agent.bundle"
rm -rf "$PMS_DIR/Scanners/Series/ta_config.json"

echo "TA: Downloading Tube Archivist..."
wget "$DL_URL" -O ta.zip
echo "TA: Unpacking..."
unzip ta.zip -d .
mv tubearchivist-plex-main/ TubeArchivist-Agent.bundle/


cd /tmp/TubeArchivist-Agent.bundle

echo "TA: Setting up config..."
mv Scanners/Series/sample-ta_config.json Scanners/Series/ta_config.json
sed -i "s,http://tubearchivist.local,${TA_URL},g" Scanners/Series/ta_config.json
sed -i "s,xxxxxxxxxxxxxxxx,${TA_API_KEY},g" Scanners/Series/ta_config.json
echo "TA: Config is set to: "
cat Scanners/Series/ta_config.json

echo "TA: Installing Scanner..."
cp -r Scanners "$PMS_DIR"
rm -r Scanners
chown -R abc: "$PMS_DIR/Scanners"


echo "TA: Installing Agent..."
cd /tmp/
cp -r TubeArchivist-Agent.bundle "$PMS_DIR/Plug-ins/"
chown -R abc: "$PMS_DIR/Plug-ins/TubeArchivist-Agent.bundle"
cd "$PMS_DIR/Plug-ins/TubeArchivist-Agent.bundle"

echo "Updating DefaultPrefs.json (default agent settings)..."
sed -i "s,http://tubearchivist.local,${TA_URL},g" Contents/DefaultPrefs.json
sed -i "s,XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX,${TA_API_KEY},g" Contents/DefaultPrefs.json
sed -i "s,true,false,g" Contents/DefaultPrefs.json

echo "Installation complete!"
