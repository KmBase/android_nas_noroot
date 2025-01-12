#!/bin/bash

# 更新软件包并安装所需工具
pkg install termux-tools -y
# termux-change-repo
# termux-setup-storage
pkg install cloudflared -y
pkg install alist -y
pkg install aria2 -y

# 创建配置文件目录
CONFIG_DIR="$PREFIX/etc/"
if [! -d "$CONFIG_DIR" ]; then
    mkdir -p "$CONFIG_DIR"
fi
CONFIG_FILE="$CONFIG_DIR/config.txt"

# 获取用户输入的关键信息
read -p "set tunnel token of cloudflare: " tunnel_token
read -p "set admin password of alist: " alist_password

# 写入配置文件
echo "tunnel_token=$tunnel_token" > "$CONFIG_FILE"
echo "alist_password=$alist_password" >> "$CONFIG_FILE"

# 读取配置信息
source "$CONFIG_FILE"

# 构建启动命令字符串，先判断服务是否运行
cloudflared_main="nohup cloudflared tunnel --no-autoupdate run $tunnel_token &"
alist_main="nohup alist admin set $alist_password; nohup alist server --port 5244 &"
aria2_main="nohup aria2c --enable-rpc --rpc-allow-origin-all &"

cloudflared_cmd="
if! pgrep -x "cloudflared" > /dev/null; then
    $cloudflared_main
fi
"
alist_cmd="
if! pgrep -x "alist" > /dev/null; then
    $alist_main"
fi
"
aria2_cmd="
if! pgrep -x "aria2" > /dev/null; then
    $aria2_main"
fi
"
# 追加到 termux-login.sh
echo "$cloudflared_cmd" >> $PREFIX/etc/termux-login.sh
echo "$alist_cmd" >> $PREFIX/etc/termux-login.sh
echo "$aria2_cmd" >> $PREFIX/etc/termux-login.sh

# 启动服务
eval $cloudflared_main
eval $alist_cmd
eval $aria2_cmd