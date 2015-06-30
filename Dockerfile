FROM resin/rpi-raspbian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN apt-get -y update && apt-get install --no-install-recommends -y ruby forked-daapd avahi-utils && \
          rm -Rf /var/lib/apt/lists/*

VOLUME /media
ADD forked-daapd.conf.erb /etc/forked-daapd.conf.erb
ADD start /usr/sbin/start

EXPOSE 3689

CMD ["bash", "/usr/sbin/start"]
