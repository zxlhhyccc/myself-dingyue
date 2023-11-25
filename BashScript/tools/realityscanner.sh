#!/bin/bash

# 设置下载链接
download_url="https://github.com/XTLS/RealiTLScanner/releases/download/v0.1.2/RealiTLScanner-linux-64"

# 设置下载文件名
download_filename="RealiTLScanner-linux-64"

# 获取用户输入的IP地址
read -p "Enter the IP address: " ip_address

# 下载RealiTLScanner-linux-64
wget "$download_url" -O "$download_filename"

# 给下载的文件添加执行权限
chmod +x "$download_filename"

# 执行RealiTLScanner-linux-64命令，传递用户输入的IP地址
./"$download_filename" -addr "$ip_address" -port 443 -thread 100 -timeOut 5

# 删除RealiTLScanner-linux-64
rm "$download_filename"
