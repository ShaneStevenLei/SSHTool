#!/bin/bash

exe_path=$(cd "$(dirname "$0")"; pwd)

if [[ ! -f ${exe_path}/ssh_tool.config ]]
then
	read -p "配置文件${exe_path}/ssh_tool.config不存在,是否创建(Y/N)" -s create_config
	case ${create_config} in
		'Y'|'y')
			echo 'key=' >> ${exe_path}/ssh_tool.config
			echo 'user=' >> ${exe_path}/ssh_tool.config
			echo 'port=' >> ${exe_path}/ssh_tool.config
			echo 'host=' >> ${exe_path}/ssh_tool.config
			echo "创建完成，请修改配置文件${exe_path}/ssh_tool.config"
			exit
			;;
		'N'|'n')
			exit
			;;
		*)
			exit
			;;
	esac
fi

key=`cat ${exe_path}/ssh_tool.config | grep 'key' | awk -F '=' '{print $2}' | head -n 1`
user=`cat ${exe_path}/ssh_tool.config | grep 'user' | awk -F '=' '{print $2}' | head -n 1`
port=`cat ${exe_path}/ssh_tool.config | grep 'port' | awk -F '=' '{print $2}' | head -n 1`
host=`cat ${exe_path}/ssh_tool.config | grep 'host' | awk -F '=' '{print $2}' | head -n 1`

if [[ $key == '' ]]
then
	echo '请在配置文件中设置key'
	exit
fi

if [[ $user == '' ]]
then
	echo '请在配置文件中设置user'
	exit
fi

if [[ $port == '' ]]
then
	echo '请在配置文件中设置port'
	exit
fi

if [[ $host == '' ]]
then
	echo '请在配置文件中设置host'
	exit
fi


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

cat << EOF
----------------------------------
    1. jump to $host
    2. generate auth key
----------------------------------
EOF
read -p 'Please input your choose:' -n 1 -t 10 -e choose
case $choose in
	1)
		v_code=`oathtool --totp -b -d 6 $key`
		expect ${exe_path}/ssh_tool.expect $user $port $host $v_code
		;;
	2)
		oathtool --totp -b -d 6 $key
		;;
	*)
		echo 'Error input!'
		;;
esac
