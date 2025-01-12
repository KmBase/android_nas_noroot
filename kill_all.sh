#!/bin/bash

# 关闭所有服务并删除日志文件
pkill cloudflared & pkill alist & pkill aria2c & pkill transmission-daemon 