# SSHTool
SSH登陆工具

## 安装依赖软件
### 1. SSH
### 2. expect
### 3. oauthtool

Mac OS X, with Homebrew
`brew install oath-toolkit`

Linux, dpkg-based
`apt-get install oathtool`

Linux, rpm-based
`yum install oathtool`

## 配置
创建ssh_tool.config并写入以下配置
```
# Google二次验证的秘钥
key=
# 用户名
user=
# 端口号
port=
# 远程地址
host=
```

## 使用
```
./ssh_tool.sh
```
