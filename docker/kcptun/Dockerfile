# build for amd64
FROM alpine:latest

# build for arm32 like [raspberry pi] or [tinker board]
#FROM arm32v6/alpine:latest

MAINTAINER Wang Jie <twj31470952@gmail.com>

# for chinese user
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk update && apk add --no-cache go git libc-dev && \
    mkdir /go && export GOPATH=/go && \
    go get -u github.com/xtaci/kcptun/client && \
    go get -u github.com/xtaci/kcptun/server && \
    cp $GOPATH/bin/client /usr/local/bin/kcptun-client && \
    cp $GOPATH/bin/server /usr/local/bin/kcptun-server && \
    rm -rf /go && apk del git go libc-dev
