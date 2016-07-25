#!/bin/bash

key=''
user=''
port=''
host=''

if [[ `which ssh` == '' ]]
then
   echo '请先安装SSH'
   exit
fi

if [[ `which expect` == '' ]]
then
   echo '请先安装expect'
   exit
fi

if [[ `which oathtool` == '' ]]
then
   echo '请先安装oathtool'
   echo 'Linux, dpkg-based(Ubuntu): sudo apt-get install oathtool'
   echo 'Linux, rpm-based: sudo yum install oathtool'
   echo 'Mac OS X, with Homebrew: brew install oath-toolkit'
   exit
fi

v_code=`oathtool --totp -b -d 6 $key`
./ssh_tool.expect $user $port $host $v_code
