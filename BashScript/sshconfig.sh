#!/bin/bash

# 拼接完整的文件路径
ssh_key_file="$HOME/.ssh/id_rsa"

# 检查文件是否存在
if [ -e "$ssh_key_file" ]; then
    echo "SSH key file ($ssh_key_file) already exists. No action needed."
else
    echo "SSH key file does not exist. Generate ssh."
    # 生成 SSH 密钥到~/.ssh/id_rsa
    ssh-keygen -t rsa
fi

    # 获取用户输入的端口号、用户名和IP地址
    read -p "Enter the SSH port (default is 22): " port
    read -p "Enter the username: " username
    read -p "Enter the IP address: " ip_address

    # 如果用户未输入端口号，则使用默认端口号 22
    port=${port:-22}

    # 构建 ssh-copy-id 命令
    ssh_copy_id_command="ssh-copy-id -p $port $username@$ip_address"

    # 执行命令
    echo "Running: $ssh_copy_id_command"
    $ssh_copy_id_command

    echo "You can now connect to your VPS using: ssh -p $port $username@$ip_address"
