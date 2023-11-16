## 简介
本仓库为个人自用仓库
## vps测试
1. 回程路由
```bash
curl https://raw.githubusercontent.com/zhanghanyun/backtrace/main/install.sh -sSf | sh
```
2. vps解锁
```bash
bash <(curl -Ls unlock.moe)
```
## 脚本文件
1. git一键配置

 ```bash
  bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/GitConfig/GitConfig.sh)
 ```
 vps ssh配置
 ```bash
  bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/sshconfig.sh)
 ```
2. sing-box hy2 ws reality三合一脚本

```bash
bash <(curl -fsSL https://github.com/vveg26/sing-box-reality-hysteria2/raw/main/beta.sh)
```

3. 证书一键申请

```bash
bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/SSLAutoInstall/SSLAutoInstall.sh)
```
4. nginx

 安装
```bash
bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/nginx-onekey/ngx.sh) --install
```
 卸载
```bash
bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/nginx-onekey/ngx.sh) --uninstall
```
 更新
```bash
bash <(curl -Ls https://raw.githubusercontent.com/vveg26/myself/main/BashScript/nginx-onekey/ngx.sh) --update
```
5. docker官方脚本
```bash
curl -fsSL https://get.docker.com | bash -s docker
```
6. 面板类
casaos
```bash
curl -fsSL https://get.casaos.io | sudo bash
```
