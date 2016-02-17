# samba-alpine
A simple and super lightweight Samba docker container, based on the latest Alpine Linux base image 🐧🐋💻.

NetBIOS is disabled by default since this container is only providing smbd on port 445.

Quick start:
```shell
docker run -d -p 445:445 -v /path/to/share/:/shared --name samba pwntr/samba-alpine
```

With your own smb.conf config:
```shell
docker run -d -p 445:445 -v /path/to/smbconf/:/config -v /path/to/share/:/shared --name samba pwntr/samba-alpine
```

To have the container start when the host boots, add docker's restart policy:
```shell
docker run -d --restart=always -p 445:445 -v /path/to/share/:/shared --name samba pwntr/samba-alpine
```
