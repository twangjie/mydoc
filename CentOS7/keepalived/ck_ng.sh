#!/bin/bash

#检查nginx进程是否存在
counter=$(ps -C nginx --no-heading|wc -l)
if [ "${counter}" = "0" ]; then

    #尝试启动一次nginx，停止5秒后再次检测
    systemctl restart nginx

    sleep 5

    counter=$(ps -C nginx --no-heading|wc -l)

    if [ "${counter}" = "0" ]; then
		#如果启动没成功，就杀掉keepalive触发主备切换
        systemctl stop keepalived 
    fi
fi

