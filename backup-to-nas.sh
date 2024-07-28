#!/usr/bin/env bash
set -ueE  # same as: `set -o errexit -o errtrace`
trap 'echo Backup failed!' ERR 

backup_docker_volume(){
    DVOL=$1
    docker run --rm \
        --mount source=${DVOL},target=/volume \
        -v $(pwd):/backup \
        busybox \
        tar -czvf /backup/${DVOL}_backup.tar.gz /volume
}


# set smb server and auth vars
source .env
backup_ip="192.168.0.9"
DUMPFILE="immich_dump.sql.gz"
echo "Creating backups and uploading to $CIFS_USERNAME@${backup_ip}"


docker exec -t immich_postgres pg_dumpall --clean --if-exists --username=postgres | gzip > "./$DUMPFILE"
if [ -f "./$DUMPFILE" ]; then
    echo "Dump succesfull. Copying to server..."
    ssh "$CIFS_USERNAME@${backup_ip}" "mkdir /mnt/storage/backup/docker" && \
    scp "./$DUMPFILE" "$CIFS_USERNAME@${backup_ip}:/mnt/storage/backup/docker/$DUMPFILE"
    echo "Renaming last backup to $DUMPFILE.old"
    rm -f "./$DUMPFILE.old" && \
    mv "./$DUMPFILE" "./$DUMPFILE.old"
    echo "Backup complete"
else
    echo "Database dump failed!"
fi

