FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y icecast2

ADD icecast.xml /etc/icecast.xml.noconfig
ADD start.sh /etc/icecast.start.sh

CMD ["/etc/icecast.start.sh"]
