#!/bin/sh
set -ex
BACKUP_STORE=/tmp/backup_store
if [ ! -d "$BACKUP_STORE" ]; then
    echo "[$(date)] Create $BACKUP_STORE/backup.last directory"
    mkdir -p $BACKUP_STORE/backup.last
fi
SOURCE=$1
echo "[$(date)] Rsyncing $SOURCE into $BACKUP_STORE/backup.last"
/usr/bin/rsync -a --no-o --delete --safe-links $SOURCE/* $BACKUP_STORE/backup.last
echo "[$(date)] Rsync $SOURCE into $BACKUP_STORE/backup.last done!"

echo "[$(date)] Archiving /tmp/backup_store/backup.last"
/bin/tar cvzf /tmp/backup.tar -C /tmp/backup_store/backup.last . --exclude retrieved.tgz

echo "[$(date)] Upload archive to S3"
/usr/bin/aws s3 cp /tmp/backup.tar $2
