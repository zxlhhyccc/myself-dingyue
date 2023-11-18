#!/bin/bash

set -e

# 检测系统发行版
if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $ID == "ubuntu" || $ID == "debian" ]]; then
        PACKAGE_MANAGER="apt"
    elif [[ $ID == "rhel" || $ID == "centos" || $ID == "oracle" || $ID == "rocky" || $ID == "almalinux" ]]; then
        PACKAGE_MANAGER="yum"
    else
        echo "Unsupported Linux distribution."
        exit 1
    fi
elif [ -f /etc/redhat-release ]; then
    PACKAGE_MANAGER="yum"
else
    echo "Unsupported Linux distribution."
    exit 1
fi

# 安装nginx
install_nginx() {
    if [ "$PACKAGE_MANAGER" == "apt" ]; then
        sudo apt update
        sudo apt install -y curl gnupg2 ca-certificates lsb-release
        
        if [ "$ID" == "debian" ]; then
            sudo apt install -y debian-archive-keyring
        elif [ "$ID" == "ubuntu" ]; then
            sudo apt install -y ubuntu-keyring
        fi
        
        curl https://nginx.org/keys/nginx_signing.key | sudo gpg --dearmor --output /usr/share/keyrings/nginx-archive-keyring.gpg
        
        echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/$ID $VERSION_CODENAME nginx" \
            | sudo tee /etc/apt/sources.list.d/nginx.list
        
        echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
            | sudo tee /etc/apt/preferences.d/99nginx
        
        sudo apt update
        sudo apt install -y nginx
    elif [ "$PACKAGE_MANAGER" == "yum" ]; then
        # 安装 yum-utils
        sudo yum install -y yum-utils
    
        # 创建 Nginx 的 yum 仓库文件
        sudo tee /etc/yum.repos.d/nginx.repo > /dev/null <<EOT
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOT
    
        #sudo yum update -y
        # 启用 mainline 版本的 Nginx 仓库
        sudo yum-config-manager --enable nginx-mainline
    
        # 安装 Nginx
        sudo yum install -y nginx
    fi

    echo "Nginx 已成功安装。"
}
# 卸载nginx
uninstall_nginx() {
    # 停止nginx服务
    sudo systemctl stop nginx
    
    # 删除nginx软件包
    if [ -x "$(command -v apt)" ]; then
        sudo apt remove --purge -y nginx
    elif [ -x "$(command -v yum)" ]; then
        sudo yum remove -y nginx
    else
        echo "Unsupported package manager."
        exit 1
    fi
    
    # 删除nginx配置文件和日志目录
    sudo rm -rf /etc/nginx /var/log/nginx
    
    echo "Nginx has been successfully uninstalled."
}

# 更新nginx
update_nginx() {
    if [ "$PACKAGE_MANAGER" == "apt" ]; then
        sudo apt update
        sudo apt upgrade -y nginx
    elif [ "$PACKAGE_MANAGER" == "yum" ]; then
        sudo yum update -y nginx
    fi
    
    echo "Nginx has been successfully updated."
}

# 解析命令行参数
if [ "$1" == "--install" ]; then
    install_nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
elif [ "$1" == "--uninstall" ]; then
    uninstall_nginx
elif [ "$1" == "--update" ]; then
    update_nginx
else
    echo "Invalid argument. Usage: nginx.sh --install | --uninstall | --update"
    exit 1
fi
