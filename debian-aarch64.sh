#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

ISLINUX=true
OSTYPE="linux"

if [ "x$(uname)" != "xLinux" ]; then
  echo ""
  echo 'Warning: Non-Linux operating systems are not supported! After downloading, please copy the tar.gz file to linux.'  
  ISLINUX=false
fi

if [ -z "${ARCH}" ]; then
  case "$(uname -m)" in
  aarch64)
    ARCH=aarch64
    ;;
  *)
    echo "${ARCH}, isn't supported!"
    exit 1
    ;;
  esac
fi

echo -e "**********************************"
echo -e "* System Required: Debian 10/11  *"
echo -e "* System Required: Debian 10/11  *"
echo -e "* Description: 环境自动部署脚本    *"
echo -e "* Version: 0.0.1                 *"
echo -e "* Author: Bess Croft              *"
echo -e "* Blog: https://besscroft.com    *"
echo -e "**********************************"

sh_ver="0.0.1"
github="raw.githubusercontent.com/besscroft/linuxsh/master"

# 开始菜单
start_menu(){
clear
echo && echo -e " Debian 一键安装管理脚本 [v${sh_ver}]
 GitHub: [v${github}]
  
-- 欢迎使用！！！ --  

 0. 升级系统
————————————管理————————————
 1. 安装常用软件包
 2. 留空
 3. 留空
 4. 安装开发软件
 5. 安装一些软件
————————————优化————————————
 6. 系统相关设置
 7. BBR 开启
 8. 留空
 9. 升级脚本
 10. 退出脚本
————————————————————————————————" && echo
read -p " 请输入数字 [0-10]:" num
case "$num" in
	0)
	Update_Debian
	;;
	1)
	Install_package
	;;
	2)
	start_menu
	;;
	3)
	start_menu
	;;
	4)
	start_menu3
	;;
	5)
	start_menu2
	;;
	6)
	System_Settings
	;;
	7)
	BBR_start
	;;
	8)
	start_menu
	;;
	9)
	Update_Shell
	;;
	10)
	exit 1
	;;
	*)
	clear
	echo -e ":请输入正确数字 [0-10]"
	sleep 5s
	start_menu
	;;
esac
}

# 子菜单 安装软件
start_menu2(){
clear
echo && echo -e " Debian 一键安装管理脚本 [v${sh_ver}]
  
-- 二级菜单 --  

 0. 回到上级菜单
————————————管理————————————
 1. 安装 Vesta 面板
 2. 安装 Docker(官方源)
————————————优化————————————
 9. 退出脚本
————————————————————————————————" && echo
read -p " 请输入数字 [0-9]:" num
case "$num" in
	0)
	start_menu
	;;
	1)
	Install_Vesta
	;;
	2)
	Install_DockerCommunity
	;;
	9)
	exit 1
	;;
	*)
	clear
	echo -e ":请输入正确数字 [0-9]"
	sleep 5s
	start_menu2
	;;
esac
}

# 子菜单 安装开发软件
start_menu3(){
clear
echo && echo -e " Debian 一键安装管理脚本 [v${sh_ver}]
  
-- 二级菜单，安装开发软件 --  

 0. 回到上级菜单
————————————管理————————————
 1. 安装 Docker 版 Redis
————————————优化————————————
 9. 退出脚本
————————————————————————————————" && echo
read -p " 请输入数字 [0-9]:" num
case "$num" in
	0)
	start_menu
	;;
	1)
	Install_Redis
	;;
	9)
	exit 1
	;;
	*)
	clear
	echo -e ":请输入正确数字 [0-9]"
	sleep 5s
	start_menu3
	;;
esac
}

##执行方法##
# 升级系统
Update_Debian(){
	stty erase '^H' && read -p "准备好更新系统了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "开始更新系统中..."
		if [[ "${release}" == "ubuntu" ]]; then
		apt-get update -y
		apt-get upgrade -y
		fi
		echo -e "系统升级成功！"
	fi
}

# 安装常用软件包
Install_package(){
	stty erase '^H' && read -p "准备好安装了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "$开始安装中..."
		if [[ "${release}" == "debian" ]]; then
		apt install -y curl vim wget unzip git nano iftop htop sudo
		fi
		echo -e "安装成功！"
	fi
}

# 系统相关设置
System_Settings(){
	stty erase '^H' && read -p "准备好设置系统配置了吗 ?(设置时区为 Asia/Shanghai) [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "开始设置系统配置中..."
		ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
		echo -e "设置成功！"
	fi
}

# BBR开启
BBR_start(){
	stty erase '^H' && read -p "准备开启 BBR 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "开始设置 BBR 配置中..."
		echo 'net.core.default_qdisc=fq' | sudo tee -a /etc/sysctl.conf
		echo 'net.ipv4.tcp_congestion_control=bbr' | sudo tee -a /etc/sysctl.conf
		sysctl -p
		sysctl net.ipv4.tcp_congestion_control
		sysctl net.ipv4.tcp_available_congestion_control
		lsmod | grep bbr
		echo -e "BBR 启动成功！"
	fi
}

# 更新脚本
Update_Shell(){
	echo -e "当前版本为 [ ${sh_ver} ]，开始检测最新版本..."
	sh_new_ver=$(wget --no-check-certificate -qO- "http://${github}/debian-aarch64.sh"|grep 'sh_ver="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
	[[ -z ${sh_new_ver} ]] && echo -e " 检测最新版本失败 !" && start_menu
	if [[ ${sh_new_ver} != ${sh_ver} ]]; then
		echo -e "发现新版本[ ${sh_new_ver} ]，是否更新？[Y/n]"
		read -p "(默认: y):" yn
		[[ -z "${yn}" ]] && yn="y"
		if [[ ${yn} == [Yy] ]]; then
			wget -N --no-check-certificate http://${github}/debian-aarch64.sh && chmod +x debian-aarch64.sh
			echo -e "脚本已更新为最新版本[ ${sh_new_ver} ] !"
		else
			echo && echo "	已取消..." && echo
		fi
	else
		echo -e "当前已是最新版本[ ${sh_new_ver} ] !"
		sleep 5s
	fi
}

# 安装 Vesta 面板
Install_Vesta(){
	stty erase '^H' && read -p "准备好安装 Vesta 面板了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "开始安装 Vesta 面板中..."
		echo -e "安装过程中需要手动确认..."
		curl -O http://vestacp.com/pub/vst-install.sh && sudo bash vst-install.sh
		echo -e "Vesta 面板安装成功！"
	fi
}

# 安装 Docker
Install_DockerCommunity(){
	stty erase '^H' && read -p "准备好安装 Docker 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "开始安装 Docker 中..."
		if [[ "${release}" == "ubuntu" ]]; then
		sudo apt-get remove docker docker-engine docker.io containerd runc
		sudo apt-get update
		sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
        sudo mkdir -p /etc/apt/keyrings
		curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo apt-get update
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
		docker version
		systemctl start docker
		systemctl enable docker
		fi
		echo -e "安装成功！"
		echo -e "已启动 Docker！"
		echo -e "已设置 Docker 开机自启！"
		stty erase '^H' && read -p "想运行一下 hello-world 镜像吗 ? [Y/n] :" yn
		[ -z "${yn}" ] && yn="y"
		if [[ $yn == [Yy] ]]; then
			echo -e "${Info} 开始 pull..."
			docker run hello-world
		fi
	fi
}

# 安装 Redis
Install_Redis(){
	stty erase '^H' && read -p "准备好安装 Docker 版 Redis 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "开始安装 Docker 版 Redis 面板中..."
		echo
		echo "Please enter conf 文件夹路径:"
		read -p "(default URI: /home/conf):" redis_conf
		[ -z "${redis_conf}" ] && redis_conf="/home/conf"
		echo
		echo "method = ${redis_conf}"
		echo
		echo "Please enter data 文件夹路径:"
		read -p "(default URI: /home/data):" redis_data
		[ -z "${redis_data}" ] && redis_data="/home/data"
		echo
		echo "method = ${redis_data}"
		echo
		echo "Please enter redis 端口:"
		read -p "(default port: 6379):" redis_port
		[ -z "${redis_port}" ] && redis_port="6379"
		echo
		echo "port = ${redis_port}"
		echo
		echo "Please enter redis name:"
		read -p "(default name: docker-redis):" redis_name
		[ -z "${redis_name}" ] && redis_name="docker-redis"
		echo
		echo "port = ${redis_name}"
		echo
		echo "Please enter redis password:"
		read -p "(default password: password):" redis_password
		[ -z "${redis_password}" ] && redis_password="password"
		echo
		echo "port = ${redis_password}"
		echo
		mkdir -p  ${redis_conf}
		echo
		mkdir -p  ${redis_data}
		docker pull redis:6.0.9
		docker run -d -p ${redis_port}:${redis_port} --restart always --name ${redis_name} \
			-v ${redis_conf}/redis.conf:/usr/local/etc/redis/redis.conf \
			-v ${redis_data}:/data \
			redis:6.0.9 redis-server /usr/local/etc/redis/redis.conf \
			--requirepass ${redis_password} --appendonly yes
		echo
		Install_Completed_Redis
		echo -e "Docker 版 Redis 面板安装成功！"
	fi
}

# Docker 版 Redis 安装完成打印信息
Install_Completed_Redis() {
    clear
    echo -e "以下是配置信息！"
	echo
    echo -e "Your Server IP        :  $(get_ip)"
    echo -e "Your Server Port      :  ${redis_port}"
    echo -e "Your Password         :  ${redis_password}"
    echo -e "data 目录             :  ${redis_data}"
    echo -e "conf 目录             :  ${redis_conf}"
    echo
}

##系统检测组件##

# 检查系统
check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
}

# 获取 ip
get_ip() {
    local IP=$( ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^192\.168|^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\." | head -n 1 )
    [ -z ${IP} ] && IP=$( wget -qO- -t1 -T2 ipv4.icanhazip.com )
    [ -z ${IP} ] && IP=$( wget -qO- -t1 -T2 ipinfo.io/ip )
    [ ! -z ${IP} ] && echo ${IP} || echo
}

check_sys
[[ ${release} != "debian" ]] && echo -e "本脚本不支持当前系统 ${release} !" && exit 1
start_menu