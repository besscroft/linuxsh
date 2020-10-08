#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo -e "**********************************"
echo -e "* System Required: Ubuntu 18.04  *"
echo -e "* Description: 环境自动部署脚本  *"
echo -e "* Version: 0.0.2                 *"
echo -e "* Author: BessCroft              *"
echo -e "* Blog: https://52bess.com       *"
echo -e "**********************************"

sh_ver="0.0.2"
github="raw.githubusercontent.com/besscroft/linuxShellGO/master"

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

#开始菜单
start_menu(){
clear
echo && echo -e " Ubuntu一键安装管理脚本 ${green}[v${sh_ver}]${green}
 GitHub: ${green}[v${github}]${green}
  
-- 欢迎使用！！！ --  

 ${green}0.${green} 升级系统
————————————管理————————————
 ${green}1.${green} 安装常用软件包
 ${red}2.${red} 安装或更新编译环境包
 ${red}3.${red} 安装最新稳定版内核
 ${green}4.${green} 安装开发软件
 ${green}5.${green} 安装一些软件
————————————优化————————————
 ${green}6.${green} 系统相关设置
 ${green}7.${green} BBR开启
 ${red}8.${red} 系统优化
 ${plain}9.${plain} 升级脚本
 ${plain}10.${plain} 退出脚本
————————————————————————————————" && echo
read -p " 请输入数字 [0-10]:" num
case "$num" in
	0)
	Update_Ubuntu
	;;
	1)
	Install_package
	;;
	2)
	Install_make_package
	;;
	3)
	Install_ml_kernel
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
	System_Optim
	;;
	9)
	Update_Shell
	;;
	10)
	exit 1
	;;
	*)
	clear
	echo -e "${Error}:请输入正确数字 [0-10]"
	sleep 5s
	start_menu
	;;
esac
}

#子菜单 安装软件
start_menu2(){
clear
echo && echo -e " Ubuntu一键安装管理脚本 ${green}[v${sh_ver}]${green}
  
-- 二级菜单 --  

 ${green}0.${green} 回到上级菜单
————————————管理————————————
 ${green}1.${green} 安装SSR(Docker)
 ${green}2.${green} 安装BT面板
 ${green}3.${green} 安装Docker(阿里源)
 ${green}4.${green} 安装Docker
————————————优化————————————
 ${green}9.${plain} 退出脚本
————————————————————————————————" && echo
read -p " 请输入数字 [0-9]:" num
case "$num" in
	0)
	start_menu
	;;
	1)
	Install_SSR_Docker
	;;
	2)
	Install_BT
	;;
	3)
	Install_DockerCommunity_ali
	;;
	4)
	Install_DockerCommunity
	;;
	9)
	exit 1
	;;
	*)
	clear
	echo -e "${Error}:请输入正确数字 [0-9]"
	sleep 5s
	start_menu2
	;;
esac
}

#子菜单 安装开发软件
start_menu3(){
clear
echo && echo -e " Ubuntu一键安装管理脚本 ${green}[v${sh_ver}]${green}
  
-- 二级菜单，安装开发软件 --  

 ${green}0.${green} 回到上级菜单
————————————管理————————————
 ${green}1.${green} 安装Redis
————————————优化————————————
 ${green}9.${plain} 退出脚本
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
	echo -e "${Error}:请输入正确数字 [0-9]"
	sleep 5s
	start_menu3
	;;
esac
}

##执行方法##
#升级系统
Update_Ubuntu(){
	stty erase '^H' && read -p "准备好更新系统了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始更新系统中..."
		if [[ "${release}" == "ubuntu" ]]; then
		apt update -y
		apt upgrade -y
		fi
		echo -e "${Info}系统升级成功！"
	fi
}

#安装常用软件包
Install_package(){
	stty erase '^H' && read -p "准备好安装了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始安装中..."
		if [[ "${release}" == "ubuntu" ]]; then
		apt install -y curl vim wget unzip git nano iftop htop
		fi
		echo -e "${Info}安装成功！"
	fi
}

#安装或更新编译环境包
Install_make_package(){
	stty erase '^H' && read -p "准备好安装编译环境包了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始安装编译环境包中..."
		if [[ "${release}" == "ubuntu" ]]; then
		apt install -y curl-devel expat-devel gettext-devel openssl-devel zlibdevel gcc-c++ perl-ExtUtils-MakeMaker zlib-devel bzip2-devel ncurses-devel sqlitedevel readline-devel tk-devel gcc make
		fi
		echo -e "${Info}安装成功！"
	fi
}

#安装最新稳定版内核
Install_ml_kernel(){
	echo -e "${Info} 还没写..."
}

#安装Docker
Install_DockerCommunity(){
	stty erase '^H' && read -p "准备好安装Docker了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始安装Docker中..."
		if [[ "${release}" == "ubuntu" ]]; then
		sudo apt-get remove docker docker-engine docker.io containerd runc
		sudo apt-get update
		sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
		sudo apt-get update
		sudo apt-get install docker-ce docker-ce-cli containerd.io -y
		docker version
		systemctl start docker
		systemctl enable docker
		fi
		echo -e "${Info}安装成功！"
		echo -e "${Info}已启动Docker！"
		echo -e "${Info}已设置Docker开机自启！"
		stty erase '^H' && read -p "想运行一下hello-world镜像吗 ? [Y/n] :" yn
		[ -z "${yn}" ] && yn="y"
		if [[ $yn == [Yy] ]]; then
			echo -e "${Info} 开始pull..."
			docker run hello-world
		fi
	fi
}

#安装Docker(阿里源)
Install_DockerCommunity_ali(){
	stty erase '^H' && read -p "准备好安装Docker了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始安装Docker中..."
		if [[ "${release}" == "ubuntu" ]]; then
		sudo apt-get remove docker docker-engine docker.io containerd runc
		sudo apt-get update
		sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
		curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
		sudo apt-get -y update
		sudo apt-get -y install docker-ce
		docker version
		systemctl start docker
		systemctl enable docker
		fi
		echo -e "${Info}安装成功！"
		echo -e "${Info}已启动Docker！"
		echo -e "${Info}已设置Docker开机自启！"
		stty erase '^H' && read -p "想运行一下hello-world镜像吗 ? [Y/n] :" yn
		[ -z "${yn}" ] && yn="y"
		if [[ $yn == [Yy] ]]; then
			echo -e "${Info} 开始pull..."
			docker run hello-world
		fi
	fi
}

#系统相关设置
System_Settings(){
	stty erase '^H' && read -p "准备好设置系统配置了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始设置系统配置中..."
		ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
		echo -e "${Info}设置成功！"
	fi
}

#BBR开启
BBR_start(){
	stty erase '^H' && read -p "准备开启BBR了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始设置BBR配置中..."
		echo 'net.core.default_qdisc=fq' | sudo tee -a /etc/sysctl.conf
		echo 'net.ipv4.tcp_congestion_control=bbr' | sudo tee -a /etc/sysctl.conf
		sysctl -p
		sysctl net.ipv4.tcp_congestion_control
		sysctl net.ipv4.tcp_available_congestion_control
		lsmod | grep bbr
		echo -e "${Info}BBR启动成功！"
	fi
}

#系统优化
System_Optim(){
	echo -e "${Info}还没写！"
}

#更新脚本
Update_Shell(){
	echo -e "当前版本为 [ ${sh_ver} ]，开始检测最新版本..."
	sh_new_ver=$(wget --no-check-certificate -qO- "http://${github}/Bess_Ubuntu_1804.sh"|grep 'sh_ver="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
	[[ -z ${sh_new_ver} ]] && echo -e "${Error} 检测最新版本失败 !" && start_menu
	if [[ ${sh_new_ver} != ${sh_ver} ]]; then
		echo -e "发现新版本[ ${sh_new_ver} ]，是否更新？[Y/n]"
		read -p "(默认: y):" yn
		[[ -z "${yn}" ]] && yn="y"
		if [[ ${yn} == [Yy] ]]; then
			wget -N --no-check-certificate http://${github}/Bess_Ubuntu_1804.sh && chmod +x Bess_Ubuntu_1804.sh
			echo -e "脚本已更新为最新版本[ ${sh_new_ver} ] !"
		else
			echo && echo "	已取消..." && echo
		fi
	else
		echo -e "当前已是最新版本[ ${sh_new_ver} ] !"
		sleep 5s
	fi
}

#安装SSR(Docker)
Install_SSR_Docker(){
	echo -e "${red} 请确保已经安装了Docker，否则将无法安装Docker版SSR！${green}"
	stty erase '^H' && read -p "准备安装SSR了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始安装SSR中..."
		#还没写
		echo "Please enter password:"
		read -p "(default password: 52bess.com):" shadowsockspwd
		[ -z "${shadowsockspwd}" ] && shadowsockspwd="52bess.com"
		echo
		echo "password = ${shadowsockspwd}"
		echo
		while true
		do
		echo -e "Please enter a port for [1-65535]"
		read -p "(default port: 22333):" shadowsocksport
		[ -z "${shadowsocksport}" ] && shadowsocksport="22333"
		expr ${shadowsocksport} + 0 &>/dev/null
		if [ $? -eq 0 ]; then
			if [ ${shadowsocksport} -ge 1 ] && [ ${shadowsocksport} -le 65535 ]; then
				echo
				echo "port = ${shadowsocksport}"
				echo
				break
			else
				echo -e "${red}Error:${plain} Please enter a correct number [1-65535]"
			fi
		else
			echo -e "${red}Error:${plain} Please enter a correct number [1-65535]"
		fi
		done

		echo -e "${Info} 开始pull SSR中..."
		docker pull teddysun/shadowsocks-r
		mkdir -p /etc/shadowsocks-r
		cat > /etc/shadowsocks-r/config.json <<-EOF
		{ 
			"server":"$(get_ip)", 
			"server_ipv6":"::", 
			"server_port":${shadowsocksport}, 
			"local_address":"127.0.0.1", 
			"local_port":1080, 
			"password":"${shadowsockspwd}", 
			"timeout":120, 
			"method":"chacha20-ietf", 
			"protocol":"auth_aes128_md5", 
			"protocol_param":"", 
			"obfs":"tls1.2_ticket_auth", 
			"obfs_param":"itunes.apple.com", 
			"redirect":"", 
			"dns_ipv6":false, 
			"fast_open":true, 
			"workers":1 
		}
		EOF
		docker run -d -p ${shadowsocksport}:${shadowsocksport} -p ${shadowsocksport}:${shadowsocksport}/udp --name ssr --restart=always -v /etc/shadowsocks-r:/etc/shadowsocks-r teddysun/shadowsocks-r
		Install_Completed_SSR
		echo -e "${Info}安装SSR成功！"
	fi
}

#SSR安装完成打印信息
Install_Completed_SSR() {
    clear
    echo -e "以下是配置信息！"
	echo
    echo -e "Your Server IP        : ${green} $(get_ip) ${plain}"
    echo -e "Your Server Port      : ${green} ${shadowsocksport} ${plain}"
    echo -e "Your Password         : ${green} ${shadowsockspwd} ${plain}"
    echo -e "Your Encryption Method: ${green} chacha20-ietf ${plain}"
    echo -e "Protocol              : ${green} auth_aes128_md5 ${plain}"
    echo -e "obfs                  : ${green} tls1.2_ticket_auth ${plain}"
	echo -e "obfs_param            : ${green} itunes.apple.com ${plain}"
    echo
}

#安装BT面板
Install_BT(){
	stty erase '^H' && read -p "准备好安装BT了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始安装BT面板中..."
		echo -e "${Info} 安装过程中需要手动确认..."
		wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh
		echo -e "${Info} BT面板安装成功！"
	fi
}

#安装Redis
Install_Redis(){
	echo -e "${Info} 安装脚本维护中..."
}

##系统检测组件##

#检查系统
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

#获取ip
get_ip() {
    local IP=$( ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^192\.168|^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\." | head -n 1 )
    [ -z ${IP} ] && IP=$( wget -qO- -t1 -T2 ipv4.icanhazip.com )
    [ -z ${IP} ] && IP=$( wget -qO- -t1 -T2 ipinfo.io/ip )
    [ ! -z ${IP} ] && echo ${IP} || echo
}

check_sys
[[ ${release} != "ubuntu" ]] && echo -e "${Error} 本脚本不支持当前系统 ${release} !" && exit 1
start_menu