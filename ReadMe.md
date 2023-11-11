## 简介
本仓库为个人自用仓库
## vps测试
1. 回程路由
```
curl https://raw.githubusercontent.com/zhanghanyun/backtrace/main/install.sh -sSf | sh
```
2. vps解锁
```
bash <(curl -Ls unlock.moe)
```
## 脚本文件
1. git一键配置

```
 bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/GitConfig/GitConfig.sh)
```
2. sing-box hy2 ws reality三合一脚本

```
bash <(curl -fsSL https://github.com/vveg26/sing-box-reality-hysteria2/raw/main/beta.sh)
```

3. 证书一键申请

```
bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/SSLAutoInstall/SSLAutoInstall.sh)
```
4. nginx

 安装
```
bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/nginx-onekey/ngx.sh) --install
```
 卸载
```
bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/nginx-onekey/ngx.sh) --uninstall
```
 更新
```
bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/nginx-onekey/ngx.sh) --update
```
