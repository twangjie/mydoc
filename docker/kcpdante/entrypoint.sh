#!/bin/sh

/usr/sbin/sockd -D
kcptun-server -l :21000 -t 127.0.0.1:1080 --key twangjie --crypt xtea --mode fast --mtu 1350 --sndwnd 1024 --rcvwnd 1024
