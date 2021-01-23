fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}
echo -e "\033[1;33m Se instalara¡ el servidor de \033[1;32mClash\033[0m"
echo -e "\033[1;33m Debes tener instalado previamente \033[1;32mGO Lang\033[0m"
[[ -d /usr/local/go ]] && echo -e "\033[1;33m Go Lang Instalado" || echo -e "\033[1;33m Instale Go Lang en ( *\033[1;33m menu\033[1;32m *\033[1;33m opcion 7 \033[1;32m*\033[1;33m opcion 15 \033[1;32m)"
echo -e "\033[1;33m Debes tener instalado previamente \033[1;32mTrojan Server\033[0m"
echo -e "\033[1;33m IMPORTANTE DEBES TENER LIBRES PUERTOS \033[1;32m7890 / 7891 / 7892 / 9090\033[0m"
echo -e "\033[1;33m Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
fun_ip
killall clash 1> /dev/null 2> /dev/null
echo -e "Î” Instalando Servidor Clash"
go get -u -v github.com/Dreamacro/clash 1> /dev/null 2> /dev/null
clear
echo -e "Î” Creando Directorios y Archivos"
mkdir /root/.config 1> /dev/null 2> /dev/null
mkdir /root/.config/clash 1> /dev/null 2> /dev/null
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods. VPSPack      ã€‘\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
read -p ": " troport
sed -i "s/puertodelservidor/$troport/g" /root/.config/clash/config.yaml
#sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
echo -e "\033[1;33mÎ” Escriba el password de Trojan Server"
read -p ": " tropass
#sed -i "s/clavedelservidor/$tropass/g" /root/.config/clash/config.yaml
echo -e "\033[1;33mÎ” Escriba el SNI de su metodo"
read -p ": " trosni
#sed -i "s/snidelmetodo/$trosni/g" /root/.config/clash/config.yaml
echo -e "Î” Iniciando Servidor"
echo '
port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: Rule
log-level: info
external-controller: '0.0.0.0:9090'
secret: ''

proxy-groups:
- name: "ChumoGH-ADM"
  type: select
  proxies:
    - TrojanPublic CGH
#    - V2ray CGH
#    - ShadowsocksR CGH
#    - SnellPublic ChumoGH
#    - Socks  V2rayUC ChumoGH
#    - ShadowsocksPublic ChumoGH
  url: http://www.gstatic.com/generate_204
  interval: 300
 
###################################
# ChumoGH ADM

# By ChumoGï¼ŒBy ChumoGH

rules:
- DOMAIN-SUFFIX,local,ChumoGH ADM
- DOMAIN-SUFFIX,google.com,ChumoGH ADM
- DOMAIN-KEYWORD,google,ChumoGH ADM
- DOMAIN,google.com,ChumoGH ADM
- DOMAIN-SUFFIX,ad.com,ChumoGH ADM
- SRC-IP-CIDR,192.168.1.201/32,ChumoGH ADM
- IP-CIDR,127.0.0.0/8,ChumoGH ADM
- GEOIP,IR,ChumoGH ADM
- MATCH, ChumoGH ADM

proxies:
- name: TrojanPublic CGH
  type: "trojan"
  server: ipdelservidor
  port: portaaccess
  password: claveacces
  udp: true
  sni: sniacces
  alpn:
  - h2
  - http/1.1
  skip-cert-verify: true
' > /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
screen -dmS clashse clash
cp /root/.config/clash/config.yaml /var/www/html/clash.yaml
clear
figlet -p -f smslant < /root/name
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mClash Server Instalado"
echo -e "\033[1;32mRuta de Configuracion: /root/.config/clash/config.yaml"
echo -e "\033[1;32mRuta de archivo de importacion de servidor Clash: http://$IP:81/clash.yaml"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
fi
