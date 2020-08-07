#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo -e "**********************************"
echo -e "* System Required: CentOS 7      *"
echo -e "* Description: 环境自动部署脚本  *"
echo -e "* Version: 1.0.9                 *"
echo -e "* Author: BessCroft              *"
echo -e "* Blog: https://52bess.com       *"
echo -e "**********************************"

sh_ver="1.0.9"
github="raw.githubusercontent.com/besscroft/linuxShellGO/master"

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
————————————优化————————————
 ${Green_font_prefix}5.${Font_color_suffix} 系统相关设置
 ${Green_font_prefix}6.${Font_color_suffix} BBR开启
 ${Green_font_prefix}7.${Font_color_suffix} 系统优化
 ${Green_font_prefix}9.${Font_color_suffix} 退出脚本
————————————————————————————————" && echo
read -p " 请输入数字 [0-9]:" num
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
	System_Settings
	;;
	6)
	BBR_start
	;;
	7)
	System_Optim
	;;
	9)
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
	stty erase '^H' && read -p "准备好更新系统了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始更新系统中..."
		if [[ "${release}" == "centos" ]]; then
		yum update -y
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
		if [[ "${release}" == "centos" ]]; then
		yum install -y curl vim wget unzip git nano yum-utils epel-release iftop dnf net-tools
		fi
		echo -e "${Info}安装成功！"
	fi
}

#安装编译环境包
Install_make_package(){
	stty erase '^H' && read -p "准备好安装编译环境包了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始安装编译环境包中..."
		if [[ "${release}" == "centos" ]]; then
		yum install -y curl-devel expat-devel gettext-devel openssl-devel zlibdevel gcc-c++ perl-ExtUtils-MakeMaker
		fi
		echo -e "${Info}安装成功！"
	fi
}

#安装最新稳定版内核
Install_ml_kernel(){
	stty erase '^H' && read -p "想好了要安装最新稳定版内核了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始更新内核中..."
		if [[ "${release}" == "centos" ]]; then
		yum update -y
		rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
		yum install https://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm -y
		yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
		yum --enablerepo=elrepo-kernel install kernel-ml -y
		sed -i 's/GRUB_DEFAULT=saved/GRUB_DEFAULT=0/' /etc/default/grub
		grub2-mkconfig -o /boot/grub2/grub.cfg
		fi
		echo -e "${Tip} 重启系统后，请重新运行脚本开启${Red_font_prefix}BBR${Font_color_suffix}"
		stty erase '^H' && read -p "需要重启系统后，才能成功安装(替换)新内核，是否现在重启 ? [Y/n] :" yn
		[ -z "${yn}" ] && yn="y"
		if [[ $yn == [Yy] ]]; then
			echo -e "${Info} 系统重启中..."
			reboot
		fi
	fi
}

#安装Docker
Install_DockerCommunity(){
	stty erase '^H' && read -p "准备好安装Docker了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} 开始安装Docker中..."
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