#!/bin/bash

#copy from SantyHack ss scripts
if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
fi

function install_trojan(){
CHECK=$(grep SELINUX= /etc/selinux/config | grep -v "#")
if [ "$CHECK" == "SELINUX=enforcing" ]; then
    echo -e "\033[1;31m======================================================================="
    echo -e "\033[1;31mSe detecta que S.E Linux está encendido. Para evitar fallas en la solicitud de un certificado, reinicie el VPS antes de ejecutar este script"
    echo -e "\033[1;31m======================================================================="
    read -p "¿Quieres reiniciar ahora? Por favor ingresa [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
	    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
            setenforce 0
	    echo -e "VPS Reiniciando..."
	    reboot
	fi
    exit
fi
if [ "$CHECK" == "SELINUX=permissive" ]; then
    echo -e "\033[1;31m======================================================================="
    echo -e "\033[1;31mSe detecta que S.E Linux está en un estado tolerante. Para evitar que no se pueda solicitar un certificado, reinicie el VPS antes de ejecutar este script"
    echo -e "\033[1;31m======================================================================="
    read -p "¿Quieres reiniciar ahora? Por favor ingresa [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
	    sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
            setenforce 0
	    echo -e "VPS Reiniciando..."
	    reboot
	fi
    exit
fi
if [ "$release" == "centos" ]; then
    if  [ -n "$(grep ' 6\.' /etc/redhat-release)" ] ;then
    echo -e "\033[1;31m==============="
    echo -e "\033[1;31mEl sistema actual no es compatible"
    echo -e "\033[1;31m==============="
    exit
    fi
    if  [ -n "$(grep ' 5\.' /etc/redhat-release)" ] ;then
    echo -e "\033[1;31m==============="
    echo -e "\033[1;31mEl sistema actual no es compatible"
    echo -e "\033[1;31m==============="
    exit
    fi
    systemctl stop firewalld
    systemctl disable firewalld
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
elif [ "$release" == "ubuntu" ]; then
    if  [ -n "$(grep ' 14\.' /etc/os-release)" ] ;then
    echo -e "\033[1;31m==============="
    echo -e "\033[1;31mEl sistema actual no es compatible"
    echo -e "\033[1;31m==============="
    exit
    fi
    if  [ -n "$(grep ' 12\.' /etc/os-release)" ] ;then
    echo -e "\033[1;31m==============="
    echo -e "\033[1;31mEl sistema actual no es compatible"
    echo -e "\033[1;31m==============="
    exit
    fi
    systemctl stop ufw
    systemctl disable ufw
    apt-get update
fi
$systemPackage -y install  nginx wget unzip zip curl tar >/dev/null 2>&1
systemctl enable nginx.service
echo -e "\033[1;32m======================="
echo -e "\033[1;37mIngrese el nombre de dominio vinculado a este VPS"
echo -e "\033[1;37m======================="
read your_domain
real_addr=`ping ${your_domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
local_addr=`curl ipv4.icanhazip.com`
if [ $real_addr == $local_addr ] ; then
	echo -e "\033[1;37m=========================================="
	echo -e "\033[1;32m       La resolución del nombre de dominio es normal, comience a instalar el troyano"
	echo -e "\033[1;32m=========================================="
	sleep 1s
cat > /etc/nginx/nginx.conf <<-EOF
user  root;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    #tcp_nopush     on;
    keepalive_timeout  120;
    client_max_body_size 20m;
    #gzip  on;
    server {
        listen       80;
        server_name  $your_domain;
        root /usr/share/nginx/html;
        index index.php index.html index.htm;
    }
}
EOF
	#Configurar una estación de camuflaje
	rm -rf /usr/share/nginx/html/*
	cd /usr/share/nginx/html/
	wget https://github.com/V2RaySSR/Trojan/raw/master/web.zip
    	unzip web.zip
	systemctl restart nginx.service
	#Solicitar certificado https
	mkdir /usr/src/trojan-cert
	curl https://get.acme.sh | sh
	~/.acme.sh/acme.sh  --issue  -d $your_domain  --webroot /usr/share/nginx/html/
    	~/.acme.sh/acme.sh  --installcert  -d  $your_domain   \
        --key-file   /usr/src/trojan-cert/private.key \
        --fullchain-file /usr/src/trojan-cert/fullchain.cer \
        --reloadcmd  "systemctl force-reload  nginx.service"
	if test -s /usr/src/trojan-cert/fullchain.cer; then
        cd /usr/src
	#wget https://github.com/trojan-gfw/trojan/releases/download/v1.13.0/trojan-1.13.0-linux-amd64.tar.xz
	wget https://github.com/trojan-gfw/trojan/releases/download/v1.14.0/trojan-1.14.0-linux-amd64.tar.xz
	tar xf trojan-1.*
	#Descarga el cliente troyano
	wget https://github.com/atrandys/trojan/raw/master/trojan-cli.zip
	unzip trojan-cli.zip
	cp /usr/src/trojan-cert/fullchain.cer /usr/src/trojan-cli/fullchain.cer
	trojan_passwd=$(cat /dev/urandom | head -1 | md5sum | head -c 8)
	cat > /usr/src/trojan-cli/config.json <<-EOF
{
    "run_type": "client",
    "local_addr": "127.0.0.1",
    "local_port": 1080,
    "remote_addr": "$your_domain",
    "remote_port": 443,
    "password": [
        "$trojan_passwd"
    ],
    "log_level": 1,
    "ssl": {
        "verify": true,
        "verify_hostname": true,
        "cert": "fullchain.cer",
        "cipher_tls13":"TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
	"sni": "",
        "alpn": [
            "h2",
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "curves": ""
    },
    "tcp": {
        "no_delay": true,
        "keep_alive": true,
        "fast_open": false,
        "fast_open_qlen": 20
    }
}
EOF
	rm -rf /usr/src/trojan/server.conf
	cat > /usr/src/trojan/server.conf <<-EOF
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "$trojan_passwd"
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/usr/src/trojan-cert/fullchain.cer",
        "key": "/usr/src/trojan-cert/private.key",
        "key_password": "",
        "cipher_tls13":"TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
	"prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": ""
    },
    "tcp": {
        "no_delay": true,
        "keep_alive": true,
        "fast_open": false,
        "fast_open_qlen": 20
    },
    "mysql": {
        "enabled": false,
        "server_addr": "127.0.0.1",
        "server_port": 3306,
        "database": "trojan",
        "username": "trojan",
        "password": ""
    }
}
EOF
	cd /usr/src/trojan-cli/
	zip -q -r trojan-cli.zip /usr/src/trojan-cli/
	trojan_path=$(cat /dev/urandom | head -1 | md5sum | head -c 16)
	mkdir /usr/share/nginx/html/${trojan_path}
	mv /usr/src/trojan-cli/trojan-cli.zip /usr/share/nginx/html/${trojan_path}/
	#Agregar secuencia de comandos de inicio
	
cat > ${systempwd}trojan.service <<-EOF
[Unit]  
Description=trojan  
After=network.target  
   
[Service]  
Type=simple  
PIDFile=/usr/src/trojan/trojan/trojan.pid
ExecStart=/usr/src/trojan/trojan -c "/usr/src/trojan/server.conf"  
ExecReload=  
ExecStop=/usr/src/trojan/trojan  
PrivateTmp=true  
   
[Install]  
WantedBy=multi-user.target
EOF

	chmod +x ${systempwd}trojan.service
	systemctl start trojan.service
	systemctl enable trojan.service
	echo -e "\033[1;32m======================================================================"
	echo -e "\033[1;32mEl troyano se ha instalado, utilice el enlace a continuación para descargar el cliente troyano, este cliente ha configurado todos los parámetros"
	echo -e "\033[1;32m1. Copie el enlace a continuación, ábralo en el navegador y descargue el cliente."
	echo -e "\033[1;37mhttp://${your_domain}/$trojan_path/trojan-cli.zip"
	echo -e "\033[1;31mRegistre la siguiente URL de la regla"
	echo -e "\033[1;37mhttp://${your_domain}/trojan.txt"
	echo -e "\033[1;32m2、Descomprima el paquete comprimido descargado, abra la carpeta, abra start.bat para abrir y ejecutar el cliente troyano"
	echo -e "\033[1;32m3、Abra stop.bat para cerrar el cliente troyano"
	echo -e "\033[1;32m4、El cliente troyano debe utilizarse con complementos del navegador, como switchyomega, etc."
	echo -e "\033[1;32mpermiso de acceso  https://www.v2rayssr.com/trojan-1.html ‎ Descargar complementos y tutoriales del navegador"
	echo -e "\033[1;32m======================================================================"
	else
        echo -e "\033[1;31m================================"
	echo -e "\033[1;31mNo hay resultado de aplicación para el certificado https, esta instalación falló"
	echo -e "\033[1;31m================================"
	fi
	
else
	echo -e "\033[1;31m================================"
	echo -e "\033[1;31mLa dirección de resolución del nombre de dominio no coincide con la dirección IP del VPS"
	echo -e "\033[1;31mEsta instalación falló, asegúrese de que la resolución del nombre de dominio sea normal"
	echo -e "\033[1;31m================================"
fi
}

function remove_trojan(){
    echo -e "\033[1;31m================================"
    echo -e "\033[1;31mA punto de desinstalar el troyano"
    echo -e "\033[1;31mAl mismo tiempo, desinstale el nginx instalado"
    echo -e "\033[1;31m================================"
    systemctl stop trojan
    systemctl disable trojan
    rm -f ${systempwd}trojan.service
    if [ "$release" == "centos" ]; then
        yum remove -y nginx
    else
        apt autoremove -y nginx
    fi
    rm -rf /usr/src/trojan*
    rm -rf /usr/share/nginx/html/*
    echo -e "\033[1;32m=============="
    echo -e "\033[1;32mtroyano eliminado"
    echo -e "\033[1;32m=============="
}

function bbr_boost_sh(){
    bash <(curl -L -s -k "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh")
}

start_menu(){
    clear
    echo -e "\033[1;32m ===================================="
    echo -e "\033[1;32m Secuencia de comandos automática de instalación de un clic de Trojan      "
    echo -e "\033[1;32m sistema：centos7+/debian9+/ubuntu16.04+"
    echo -e "\033[1;32m sitio web：www.v2rayssr.com （Prohibido el acceso）              "
    echo -e "\033[1;32m Este script es modificado por SantyHack, integra la aceleración BBRPLUS "
    echo -e "\033[1;32m Youtube：                "
    echo -e "\033[1;32m ===================================="
    echo
    echo -e "\033[1;31m ===================================="
    echo -e "\033[1;37m 1. instalación Trojan"
    echo -e "\033[1;31m ===================================="
    echo -e "\033[1;37m 2. Instale el script de aceleración 4 EN 1 BBRPLUS"
    echo -e "\033[1;31m ===================================="
    echo -e "\033[1;37m 3. Desinstalación Trojan"
    echo -e "\033[1;31m ===================================="
    echo -e "\033[1;37m 0. Salir"
    echo -e "\033[1;31m ===================================="
    echo
    read -p "Por favor ingrese el numero:" num
    case "$num" in
    1)
    install_trojan
    ;;
    2)
    bbr_boost_sh 
    ;;
    3)
    remove_trojan
    ;;
    0)
    exit 1
    ;;
    *)
    clear
    echo -e "\033[1;31mIngrese el número correcto"
    sleep 1s
    start_menu
    ;;
    esac
}

start_menu
