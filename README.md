# rpi-forked-daapd

Run an iTunes server on your Raspberry Pi in a Docker container.

## Container variables

DAAPD_NAME - name of the iTunes server, default 'My music on %h'
DAAPD_PORT - port used, default 3689

## Container volumes

### Media files volume

The mount point of the media files in the container is `/media`, so you have to add a `-v /path/to/your/mediafiles:/media` switch.
This directory tree is also used for the pairing files `*.remote`

### Database volume

The forked-daapd server stores its data and minipics in a sqlite database. This should be stored outside of the container. Add a
`-v /path/to/dbfiles/stored/on/your/host:/var/cache/forked-daapd` switch.

As the iTunes server depends on mDNS / avahi we need to start the container with connection to the host's network interface.

## Run the container

```bash
docker run -d -p 3689:3689 --net host -v /home/media:/media -e DAAPD_NAME=Dockerized -v /home/localdb:/var/cache/forked-daapd forked-daapd
```

```bash
avahi-browse -r -k _touch-remote._tcp
```

