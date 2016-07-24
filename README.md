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
编辑ssh_tool.sh文件
```
key='' # Google二次验证的秘钥
user='' # 用户名
port='' # 端口号
host='' # 远程地址
```

## 使用
```
./ssh_tool.sh
```
