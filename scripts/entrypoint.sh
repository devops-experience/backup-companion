#!/bin/sh

set -e

UPLOAD_NAME=${UPLOAD_NAME:-`hostname`}
S3_PATH=${S3_PATH:-s3://backup}

echo "${SCHEDULE} /usr/bin/backup ${LOCAL_PATH} ${S3_PATH}/${UPLOAD_NAME} > /proc/1/fd/1 2>&1"> /tmp/crontab
crontab /tmp/crontab

echo "[$(date)] Crontab:"
crontab -l
echo ""

crond -f
