# rpi-forked-daapd

Run an iTunes server on your Raspberry Pi in a Docker container.

## Container variables

* **DAAPD_NAME** - name of the iTunes server, default 'My music on %h'
* **DAAPD_PORT** - port used, default 3689

## Container volumes

### Media files volume

The mount point of the media files in the container is `/media`, so you have to add a `-v /path/to/your/mediafiles:/media` switch.
This directory tree is also used for the pairing files `*.remote`

### Database volume

The forked-daapd server stores its data and minipics in a sqlite database. This should be stored outside of the container. Add a
`-v /path/to/dbfiles/stored/on/your/host:/var/cache/forked-daapd` switch.

## Build the container

```bash
docker build -t forked-daapd .
```

## Run the container

As the iTunes server depends on mDNS / avahi we need to start the container with connection to the host's network interface.

```bash
docker run -d --net host --name forked-daapd -v /home/media:/media -e DAAPD_NAME=Dockerized -v /home/localdb:/var/cache/forked-daapd forked-daapd
```

## Pair your iOS device with the iTunes server

1. Download the Remote app from the App Store.
2. Add a new iTunes-Mediathek, a four digit code will appear.
3. Now watch the output of the container with `docker logs forked-daapd`
4. Edit a file in your media folder on the host machine.
   * Put the name of the iOS device in the first line
   * Put the four digit code into the second line
   * save the file
5. Now the iOS device is paired with the iTunes server.

