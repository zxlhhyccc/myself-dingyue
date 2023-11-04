#!/bin/bash

# 安装Git
echo "Installing Git..."
sudo apt-get install git -y

# 配置用户名和邮箱
read -p "Enter your name: " name
read -p "Enter your email: " email
git config --global user.name "$name"
git config --global user.email "$email"

# 配置SSH密钥
echo "Generating SSH key..."
read -p "Enter email associated with your SSH key: " ssh_email
ssh-keygen -t rsa -b 4096 -C "$ssh_email"
echo "SSH key generated."

# 输出SSH公钥
echo "Your SSH public key:"
cat ~/.ssh/id_rsa.pub

echo "Please add the public key to your code hosting service."
echo "Configuration completed."
echo "github->settings->SSH and GPG keys->new SSH Key"