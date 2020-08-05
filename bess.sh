#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo -e "**********************************"
echo -e "* System Required: CentOS 7      *"
echo -e "* Description: 环境自动部署脚本  *"
echo -e "* Version: 1.0.3                 *"
echo -e "* Author: BessCroft              *"
echo -e "* Blog: https://52bess.com       *"
echo -e "**********************************"

sh_ver="1.0.3"
github="raw.githubusercontent.com/besscroft/linuxShell/master"

Green_font_prefix="\033[32m" && Font_color_suffix="\033[0m"

#开始菜单
start_menu(){
clear
echo && echo -e " CentOS一键安装管理脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
  
-- 欢迎使用！！！ --  

 ${Green_font_prefix}0.${Font_color_suffix} 升级系统
————————————管理————————————
 ${Green_font_prefix}1.${Font_color_suffix} 安装常用软件包
 ${Green_font_prefix}2.${Font_color_suffix} 安装编译环境包
 ${Green_font_prefix}3.${Font_color_suffix} 安装最新稳定版内核
 ${Green_font_prefix}4.${Font_color_suffix} 安装Docker
 ${Green_font_prefix}5.${Font_color_suffix} 退出脚本
————————————————————————————————" && echo
read -p " 请输入数字 [0-11]:" num
case "$num" in
	0)
	Update_CentOS
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
	Install_DockerCommunity
	;;
	5)
	exit 1
	;;
	*)
	clear
	echo -e "${Error}:请输入正确数字 [0-11]"
	sleep 5s
	start_menu
	;;
esac
}

##执行方法##
#升级系统
Update_CentOS(){
	if [[ "${release}" == "centos" ]]; then
	yum update -y
	fi
	echo -e "${Info}系统升级成功！"
}

#安装常用软件包
Install_package(){
	if [[ "${release}" == "centos" ]]; then
	yum install -y curl vim wget unzip git nano yum-utils epel-release iftop dnf net-tools
	fi
	echo -e "${Info}安装成功！"
}

#安装编译环境包
Install_make_package(){
	if [[ "${release}" == "centos" ]]; then
	yum install -y curl-devel expat-devel gettext-devel openssl-devel zlibdevel gcc-c++ perl-ExtUtils-MakeMaker
	fi
	echo -e "${Info}安装成功！"
}

#安装最新稳定版内核
Install_ml_kernel(){
	echo -e "还没写！"
}

#安装Docker
Install_DockerCommunity(){
	if [[ "${release}" == "centos" ]]; then
	yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
	yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
	yum install docker-ce docker-ce-cli containerd.io -y
	systemctl start docker
	systemctl enable docker
	fi
	echo -e "${Info}安装成功！"
	echo -e "${Info}已启动Docker！"
	echo -e "${Info}已设置Docker开机自启！"
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

#检查Linux版本
check_version(){
	if [[ -s /etc/redhat-release ]]; then
		version=`grep -oE  "[0-9.]+" /etc/redhat-release | cut -d . -f 1`
	else
		version=`grep -oE  "[0-9.]+" /etc/issue | cut -d . -f 1`
	fi
	bit=`uname -m`
	if [[ ${bit} = "x86_64" ]]; then
		bit="x64"
	else
		bit="x32"
	fi
}

check_sys
check_version
[[ ${release} != "centos" ]] && echo -e "${Error} 本脚本不支持当前系统 ${release} !" && exit 1
start_menu