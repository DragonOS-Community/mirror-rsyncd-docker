FROM alpine
MAINTAINER longjin <longjin@dragonos.org>

# tzdata for time syncing
# bash for entrypoint script
RUN apk add --no-cache rsync bash tzdata

# Create entrypoint script
ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
RUN mkdir -p /docker-entrypoint.d

# SSH Server configuration file
ADD /rsyncd.tpl.conf /

# Default environment variables
ENV TZ="Asia/Shanghai" \
    LANG="C.UTF-8"

EXPOSE 873
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# RUN rsync in no daemon and expose errors to stdout
CMD [ "/usr/bin/rsync", "--no-detach", "--daemon", "--log-file=/dev/stdout" ]
