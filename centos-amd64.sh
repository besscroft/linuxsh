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
  x86_64)
    ARCH=amd64
    ;;
  *)
    echo "${ARCH}, isn't supported!"
    exit 1
    ;;
  esac
fi

echo -e "**********************************"
echo -e "* System Required: CentOS 7      *"
echo -e "* Description: 环境自动部署脚本  *"
echo -e "* Version: 1.3.2                 *"
echo -e "* Author: Bess Croft              *"
echo -e "* Blog: https://besscroft.com    *"
echo -e "**********************************"

sh_ver="1.3.2"
github="raw.githubusercontent.com/besscroft/linuxsh/master"

# 开始菜单
start_menu(){
clear
echo && echo -e " CentOS 7 一键安装管理脚本 [v${sh_ver}]
 GitHub: [v${github}]
  
-- 欢迎使用！！！ --  

 0. 升级系统
————————————管理————————————
 1. 安装常用软件包
 2. 安装或更新编译环境包
 3. 安装最新稳定版内核
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
echo && echo -e " CentOS一键安装管理脚本 [v${sh_ver}]
  
-- 二级菜单 --  

 0. 回到上级菜单
————————————管理————————————
 1. 安装 SSR(Docker)
 2. 安装 Vesta 面板
 3. 安装 Docker(阿里源)
 4. 安装 Docker(官方源)
 5. 安装 Docker 版 CCAA
 6. 安装 SS-Rust(Docker 版)
————————————优化————————————
 9. 退出脚本
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
	Install_Vesta
	;;
	3)
	Install_DockerCommunity_ali
	;;
	4)
	Install_DockerCommunity
	;;
	5)
	Install_DockerCCAA
	;;
	6)
	Install_SS_Rust_Docker
	;;
	9)
	exit 1
	;;
	*)
	clear
	echo -e "请输入正确数字 [0-9]"
	sleep 5s
	start_menu2
	;;
esac
}

# 子菜单 安装开发软件
start_menu3(){
clear
echo && echo -e " CentOS 7 一键安装管理脚本 [v${sh_ver}]
  
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
	start_menu3
	;;
	9)
	exit 1
	;;
	*)
	clear
	echo -e "请输入正确数字 [0-9]"
	sleep 5s
	start_menu3
	;;
esac
}

##执行方法##
# 升级系统
Update_CentOS(){
	stty erase '^H' && read -p "准备好更新系统了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始更新系统中..."
		if [[ "${release}" == "centos" ]]; then
		yum update -y
		yum upgrade -y
		fi
		echo -e "系统升级成功！"
	fi
}

# 安装常用软件包
Install_package(){
	stty erase '^H' && read -p "准备好安装了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始安装中..."
		if [[ "${release}" == "centos" ]]; then
		yum install -y curl vim wget unzip git nano yum-utils epel-release iftop dnf net-tools
		fi
		echo -e "安装成功！"
	fi
}

# 安装或更新编译环境包
Install_make_package(){
	stty erase '^H' && read -p "准备好安装编译环境包了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始安装编译环境包中..."
		if [[ "${release}" == "centos" ]]; then
		yum install -y curl-devel expat-devel gettext-devel openssl-devel zlibdevel gcc-c++ perl-ExtUtils-MakeMaker zlib-devel bzip2-devel ncurses-devel sqlitedevel readline-devel tk-devel gcc make
		fi
		echo -e "安装成功！"
	fi
}

# 安装最新稳定版内核
Install_ml_kernel(){
	stty erase '^H' && read -p "想好了要安装最新稳定版内核了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始更新内核中..."
		if [[ "${release}" == "centos" ]]; then
		yum update -y
		rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
		yum install https://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm -y
		yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
		yum --enablerepo=elrepo-kernel install kernel-ml -y
		sed -i 's/GRUB_DEFAULT=saved/GRUB_DEFAULT=0/' /etc/default/grub
		grub2-mkconfig -o /boot/grub2/grub.cfg
		fi
		echo -e "${Tip} 重启系统后，请重新运行脚本开启 BBR"
		stty erase '^H' && read -p "需要重启系统后，才能成功安装(替换)新内核，是否现在重启 ? [Y/n] :" yn
		[ -z "${yn}" ] && yn="y"
		if [[ $yn == [Yy] ]]; then
			echo -e " 系统重启中..."
			reboot
		fi
	fi
}

# 安装Docker
Install_DockerCommunity(){
	stty erase '^H' && read -p "准备好安装 Docker 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始安装Docker中..."
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
			echo -e " 开始 pull..."
			docker run hello-world
		fi
	fi
}

# 安装 Docker(阿里源)
Install_DockerCommunity_ali(){
	stty erase '^H' && read -p "准备好安装 Docker 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始安装 Docker 中..."
		if [[ "${release}" == "centos" ]]; then
		yum remove docker \
					docker-client \
					docker-client-latest \
					docker-common \
					docker-latest \
					docker-latest-logrotate \
					docker-logrotate \
					docker-engine
		sudo yum install -y yum-utils device-mapper-persistent-data lvm2
		sudo yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
		sudo yum makecache fast
		sudo yum -y install docker-ce
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
			echo -e " 开始 pull..."
			docker run hello-world
		fi
	fi
}

# 安装 Docker 版 CCAA
Install_DockerCCAA(){
	echo -e " 请确保已经安装了 Docker，否则将无法安装 Docker 版 CCAA！"
	stty erase '^H' && read -p "准备安装 SSR 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始安装 CCAA 中..."
		echo "Please enter password:"
		read -p "(default password: fly52linux):" ccaapwd
		[ -z "${ccaapwd}" ] && ccaapwd="fly52linux"
		echo
		echo "password = ${ccaapwd}"
		echo "Please enter 宿主机下载目录:"
		read -p "(default 下载目录: /www/wwwroot/download):" hosturl
		[ -z "${hosturl}" ] && hosturl="/www/wwwroot/download"
		echo
		echo "下载目录 = ${hosturl}"
		echo -e " 开始 pull CCAA 中..."
		mkdir -p ${hosturl}
		docker run --name="ccaa" -d -p 6080:6080 -p 6081:6081 -p 6800:6800 -p 51413:51413 \
    -v ${hosturl}:/data/ccaaDown \
    -e PASS="${ccaapwd}" \
    helloz/ccaa \
    sh -c "dccaa pass && dccaa start"
		Install_Completed_CCAA
		echo -e "安装 CCAA 成功！"
	fi
}

# CCAA 安装完成打印信息
Install_Completed_CCAA() {
    clear
    echo -e "以下是配置信息！"
	echo
    echo -e "请确保防火墙放行右侧端口:  6080、6081、6800、51413 "
    echo -e "Aria2面板访问地址      :  http://$(get_ip):6080"
    echo -e "认证密码			   :  ${ccaapwd} "
    echo
}

# 系统相关设置
System_Settings(){
	stty erase '^H' && read -p "准备好设置系统配置了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始设置系统配置中..."
		ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
		echo -e "设置成功！"
	fi
}

# BBR 开启
BBR_start(){
	stty erase '^H' && read -p "准备开启 BBR 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始设置 BBR 配置中..."
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
	sh_new_ver=$(wget --no-check-certificate -qO- "http://${github}/centos-amd64.sh"|grep 'sh_ver="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
	[[ -z ${sh_new_ver} ]] && echo -e " 检测最新版本失败 !" && start_menu
	if [[ ${sh_new_ver} != ${sh_ver} ]]; then
		echo -e "发现新版本[ ${sh_new_ver} ]，是否更新？[Y/n]"
		read -p "(默认: y):" yn
		[[ -z "${yn}" ]] && yn="y"
		if [[ ${yn} == [Yy] ]]; then
			wget -N --no-check-certificate http://${github}/centos-amd64.sh && chmod +x centos-amd64.sh
			echo -e "脚本已更新为最新版本[ ${sh_new_ver} ] !"
		else
			echo && echo "	已取消..." && echo
		fi
	else
		echo -e "当前已是最新版本[ ${sh_new_ver} ] !"
		sleep 5s
	fi
}

# 安装 SSR(Docker)
Install_SSR_Docker(){
	echo -e " 请确保已经安装了 Docker，否则将无法安装 Docker 版 SSR！"
	stty erase '^H' && read -p "准备安装 SSR 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始安装 SSR 中..."
		echo "Please enter password:"
		read -p "(default password: fly52linux):" shadowsockspwd
		[ -z "${shadowsockspwd}" ] && shadowsockspwd="fly52linux"
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
				echo -e "Error: Please enter a correct number [1-65535]"
			fi
		else
			echo -e "Error: Please enter a correct number [1-65535]"
		fi
		done
		echo "Please enter 加密 method:"
		read -p "(default method: chacha20-ietf):" shadowsocksmethod
		[ -z "${shadowsocksmethod}" ] && shadowsocksmethod="chacha20-ietf"
		echo
		echo "method = ${shadowsocksmethod}"
		echo
		echo "Please enter 协议 protocol:"
		read -p "(default method: auth_aes128_md5):" shadowsocksprotocol
		[ -z "${shadowsocksprotocol}" ] && shadowsocksprotocol="auth_aes128_md5"
		echo
		echo "method = ${shadowsocksprotocol}"
		echo
		echo "Please enter 协议参数 protocol_param:"
		read -p "(default method: 默认为空):" shadowsocksprotocolparam
		[ -z "${shadowsocksprotocolparam}" ] && shadowsocksprotocolparam=""
		echo
		echo "method = ${shadowsocksprotocolparam}"
		echo
		echo "Please enter 混淆 obfs:"
		read -p "(default method: tls1.2_ticket_auth):" shadowsocksobfs
		[ -z "${shadowsocksobfs}" ] && shadowsocksobfs="tls1.2_ticket_auth"
		echo
		echo "method = ${shadowsocksobfs}"
		echo
		echo "Please enter 混淆参数 obfs_param:"
		read -p "(default method: itunes.apple.com):" shadowsocksobfsparam
		[ -z "${shadowsocksobfsparam}" ] && shadowsocksobfsparam="itunes.apple.com"
		echo
		echo "method = ${shadowsocksobfsparam}"
		echo

		echo -e " 开始 pull SSR 中..."
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
			"method":"${shadowsocksmethod}", 
			"protocol":"${shadowsocksprotocol}", 
			"protocol_param":"${shadowsocksprotocolparam}", 
			"obfs":"${shadowsocksobfs}", 
			"obfs_param":"${shadowsocksobfsparam}", 
			"redirect":"", 
			"dns_ipv6":false, 
			"fast_open":true, 
			"workers":1 
		}
		EOF
		docker run -d -p ${shadowsocksport}:${shadowsocksport} -p ${shadowsocksport}:${shadowsocksport}/udp --name ssr --restart=always -v /etc/shadowsocks-r:/etc/shadowsocks-r teddysun/shadowsocks-r
		Install_Completed_SSR
		echo -e "安装 SSR 成功！"
	fi
}

# 安装 SS-Rust(Docker 版)
Install_SS_Rust_Docker() {
	echo -e "请确保已经安装了 Docker，否则将无法安装 Docker 版 SS-Rust！"
	stty erase '^H' && read -p "准备安装 SS-Rust 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "开始安装 SS-Rust 中..."
		echo "Please enter password:"
		read -p "(default password: fly52linux):" ssrustpwd
		[ -z "${ssrustpwd}" ] && ssrustpwd="fly52linux"
		echo
		echo "password = ${ssrustpwd}"
		echo
		while true
		do
		echo -e "Please enter a port for [1-65535]"
		read -p "(default port: 22333):" ssrustport
		[ -z "${ssrustport}" ] && ssrustport="22333"
		expr ${ssrustport} + 0 &>/dev/null
		if [ $? -eq 0 ]; then
			if [ ${ssrustport} -ge 1 ] && [ ${ssrustport} -le 65535 ]; then
				echo
				echo "port = ${ssrustport}"
				echo
				break
			else
				echo -e "Error: Please enter a correct number [1-65535]"
			fi
		else
			echo -e "Error: Please enter a correct number [1-65535]"
		fi
		done
		echo "Please enter 加密 method:"
		read -p "(default method: chacha20-ietf-poly1305):" ssrustmethod
		[ -z "${ssrustmethod}" ] && ssrustmethod="chacha20-ietf-poly1305"
		echo
		echo "method = ${ssrustmethod}"
		echo
		echo -e "开始 pull SS-Rust 中..."
		mkdir -p /etc/shadowsocks-rust
		cat > /etc/shadowsocks-rust/config.json <<-EOF
		{
			"server":"0.0.0.0",
			"server_port":${ssrustport},
			"password":"${ssrustpwd}",
			"timeout":300,
			"method":"${ssrustmethod}",
			"nameserver":"8.8.8.8",
			"mode":"tcp_and_udp"
		}
		EOF
		docker run --name ssserver-rust \
			--restart always \
			-p ${ssrustport}:${ssrustport}/tcp \
			-p ${ssrustport}:${ssrustport}/udp \
			-v /etc/shadowsocks-rust/config.json:/etc/shadowsocks-rust/config.json \
			-dit ghcr.io/shadowsocks/ssserver-rust:latest
		Install_Completed_SS_Rust
		echo -e "安装 SS-Rust 成功！"
	fi
}

# SSR 安装完成打印信息
Install_Completed_SSR() {
    clear
    echo -e "以下是配置信息！"
	echo
    echo -e "Your Server IP        :  $(get_ip) "
    echo -e "Your Server Port      :  ${shadowsocksport} "
    echo -e "Your Password         :  ${shadowsockspwd} "
    echo -e "Your Encryption Method:  ${shadowsocksmethod} "
    echo -e "Protocol              :  ${shadowsocksprotocol} "
    echo -e "protocol_param        :  ${shadowsocksprotocolparam} "
    echo -e "obfs                  :  ${shadowsocksobfs} "
	echo -e "obfs_param            :  ${shadowsocksobfsparam} "
    echo
}

# SS-Rust 安装完成打印信息
Install_Completed_SS_Rust() {
    clear
    echo -e "以下是配置信息！"
	echo
    echo -e "Your Server IP        :  $(get_ip)"
    echo -e "Your Server Port      :  ${ssrustport}"
    echo -e "Your Password         :  ${ssrustpwd}"
    echo -e "Your Encryption Method:  ${ssrustmethod}"
    echo
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

# 安装 Redis
Install_Redis(){
	stty erase '^H' && read -p "准备好安装 Docker 版 Redis 了吗 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e " 开始安装 Docker 版 Redis 面板中..."
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
		echo -e " Docker 版 Redis 面板安装成功！"
	fi
}

# Docker 版 Redis 安装完成打印信息
Install_Completed_Redis() {
    clear
    echo -e "以下是配置信息！"
	echo
    echo -e "Your Server IP        :  $(get_ip) "
    echo -e "Your Server Port      :  ${redis_port} "
    echo -e "Your Password         :  ${redis_password} "
    echo -e "data 目录             :  ${redis_data} "
    echo -e "conf 目录             :  ${redis_conf} "
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

# 检查 Linux 版本
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
[[ ${release} != "centos" ]] && echo -e " 本脚本不支持当前系统 ${release} !" && exit 1
start_menu