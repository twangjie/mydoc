# docker build -t danteproxy .
# docker build -t danteproxy --build-arg=HTTP_PROXY=http://192.168.35.3:8118/ .
# docker run -itd --name sp -p 1080:1080 danteproxy
# curl -I -4 --socks5 127.0.0.1:1080 https://www.google.com

FROM alpine:edge
MAINTAINER Wang Jie <twj31470952@gmail.com>

RUN set -xe; \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories; \
    apk --update add --no-cache dante-server@testing;

COPY sockd.conf /etc/sockd.conf
    
EXPOSE 1080

ENTRYPOINT ["/usr/sbin/sockd"]
