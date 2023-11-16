#!/bin/bash

# 检查 Homebrew 是否安装
if ! command -v brew &> /dev/null
then
    echo "Homebrew 未安装，正在安装 Homebrew..."
    /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
fi

# 检查 Homebrew 安装是否成功
if ! command -v brew &> /dev/null
then
    echo "Homebrew 安装失败，请手动安装。"
    exit 1
fi

# 定义要安装的 Formulae (普通软件包)
formulae=(
    "git"
    "python@3.12"
    "node"
)

# 定义要安装的 Casks (图形界面应用)
casks=(
    "betterdisplay"
    "obsidian"
    "vscodium"
    "brave-browser"
    "onedrive"
    "telegram"
    "warp"
    "mos"
    "picgo"
    "termius"
    "wechat"
    "notion"
    "rectangle"
    "videofusion"
    "wpsoffice"
)

# 安装 Formulae
for package in "${formulae[@]}"; do
    if brew list "$package" &> /dev/null; then
        echo "$package 已经安装，跳过..."
    else
        echo "正在安装: $package"
        brew install "$package"
    fi
done

# 安装 Casks
for app in "${casks[@]}"; do
    if brew list --cask "$app" &> /dev/null; then
        echo "$app 已经安装，跳过..."
    else
        echo "正在使用 cask 安装: $app"
        brew install --cask "$app"
    fi
done

echo "所有软件安装完成。"
