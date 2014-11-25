FROM ubuntu:14.10
MAINTAINER Shaun Keenan <me@skeenan.net>

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get update &&\
    apt-get upgrade -y -q &&\
    apt-get dist-upgrade -y -q &&\
    apt-get -y -q autoclean &&\
    apt-get -y -q autoremove &&\
    apt-get install --force-yes -y -q dnsmasq dnsutils pxelinux &&\
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    apt-get clean

RUN mkdir /var/ftpd && ln -sf /usr/lib/PXELINUX/*pxelinux.0 /var/ftpd/

ADD start /start
ADD set_host /usr/local/bin/set_host

EXPOSE 53 53/udp 67/udp 68/udp

VOLUME ["/etc/dnsmasq.d","/var/ftpd"]

CMD ["/start"]
