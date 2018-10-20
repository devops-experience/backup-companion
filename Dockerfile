FROM alpine:3.6

RUN apk update && \
    apk add --no-cache \
      rsync \
      py-pip \
      apk-cron

RUN pip install awscli

COPY scripts/backup.sh /usr/bin/backup
COPY scripts/entrypoint.sh /entrypoint

ENV SCHEDULE "* * * * *"
ENV LOCAL_PATH ""
ENV S3_PATH ""
ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""

CMD ["/entrypoint"]
