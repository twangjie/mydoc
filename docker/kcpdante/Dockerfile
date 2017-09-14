# docker build -t kcpdante .
# docker build -t kcpdante --build-arg=HTTP_PROXY=http://192.168.35.3:8118/ .
# docker run -it --rm -p 22000:21000/udp kcpdante

FROM kcptun:latest
MAINTAINER Wang Jie <twj31470952@gmail.com>

RUN set -xe; \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories; \
    apk --update add --no-cache dante-server@testing;

COPY sockd.conf /etc/sockd.conf
COPY entrypoint.sh /entrypoint.sh 
   
EXPOSE 22000/udp

ENTRYPOINT ["/entrypoint.sh"]
RUN ["chmod", "+x", "/entrypoint.sh"]