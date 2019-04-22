# samba-alpine
A simple and super lightweight Samba docker container, based on the latest Alpine Linux base image 🐧🐋💻.

By default, the share will be accessible read-only for everyone, with write access for user "rio" with password "letsdance". See smb.conf for details, or feel free to use your own config (see below).

Runs Samba's smbd and nmbd within the same container, using supervisord. Due to the fact that nmbd wants to broadcast
and become the "local master" on your subnet, you need to supply the "--network host" flag to make the server visible to the hosts subnet (likely your LAN).

Mapping the ports alone is likely not sufficient for proper discovery as the processes inside the container are only aware of the internal Docker network, and not the host network. Maybe there's a config switch somewhere to supply a target broadcast network? In any case, directly accessing the shares works just fine this way.

Quick start for the impatient (discovery on your network will work fine):
```shell
docker run -d --network host -v /path/to/share/:/shared --name samba pwntr/samba-alpine
```

Supplying port mappings only instead of --network=host might be subject to the limtations outlined above:
```shell
docker run -d -p 135:135/tcp -p 137:137/udp -p 138:138/udp -p 139:139/tcp -p 445:445/tcp -v /path/to/share/:/shared --name samba pwntr/samba-alpine
```

With your own smb.conf and supervisord.conf configs:
```shell
docker run -d -p 135:135/tcp -p 137:137/udp -p 138:138/udp -p 139:139/tcp -p 445:445/tcp -v /path/to/configs/:/config -v /path/to/share/:/shared --name samba pwntr/samba-alpine
```

To have the container start when the host boots, add docker's restart policy:
```shell
docker run -d --restart=always -p 135:135/tcp -p 137:137/udp -p 138:138/udp -p 139:139/tcp -p 445:445/tcp -v /path/to/share/:/shared --name samba pwntr/samba-alpine
```
