# Backup Companion

NOTE: Originally created by AlexDouze (https://github.com/AlexDouze)

This Docker image is designed to be used as a sidecar of another
container in a Kubernets pod. It will backup the chosen directory into
an S3 bucket.

To tune this image several environment variables can be overridden:

```
SCHEDULE: Cron formated schedule (e.g: "*/2 * * * *" for every two minutes)[default: "* * * * *" every minute]
PATH_TO_BACKUP: The path to the folder to be backed up [default: /backup]
UPLOAD_NAME: The name of the archive in S3 bucket [default: `hostname`]
S3_PATH: The S3 path for the backup (e.g: "s3://backup/")
```

You need to mount the folder to be backed up, in /backup (or elsewhere,
but override the PATH_TO_BACKUP: env var)
You also need to mount aws credentials with permission to write in your
S3_PATH bucket in /root/.aws

Example:

```
docker run -it --rm -v $HOME/.aws:/root/.aws -v backed_folder:/backup -e SCHEDULE="*/5 * * * *" -e UPLOAD_NAME=tarballName -e S3_PATH="s3://my-s3-bucket/backups" backup-companion:1.0
```
