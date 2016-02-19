FROM alpine:latest
MAINTAINER Peter Winter <peter@pwntr.com>
LABEL Description="Simple and lightweight Samba docker container, based on Alpine Linux." Version="0.1"

# update the base system
RUN apk update && apk upgrade

# install samba and clear the cache afterwards
RUN apk add samba samba-common-tools && rm -rf /var/cache/apk/*

# add a non-root user and group called "rio" with no password, no home dir, no shell, and gid/uid set to 1000
RUN addgroup -g 1000 rio && adduser -D -H -G rio -s /bin/false -u 1000 rio

# and create a samba user matching our user from above with a simple password ("letsdance")
RUN echo -e "letsdance\nletsdance" | smbpasswd -a -s rio

# create a dir for the config and the share
RUN mkdir /config /shared

# copy init files from project folder to get a default config
COPY smb.conf /config/smb.conf

# volume mappings
VOLUME /config /shared

# exposes samba's default port 445. Note: nmbd is not explicitly started within this container, so NetBIOS is not available!
EXPOSE 445

# set some defaults and start samba in foreground (-F), logging to stdout (-S), and using our config (-s path)
ENTRYPOINT ["smbd", "-F", "-S", "-s", "/config/smb.conf"]
