fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}

fun_bar () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m#"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

echo -e "\033[1;36m Se instalara¡ el servidor de \033[1;32mClash\033[0m"
echo -e "\033[1;33m Debes tener instalado previamente \033[1;32mGO Lang\033[0m"
[[ -d /usr/local/go ]] && echo -e "\033[1;33m Go Lang Instalado" || echo -e "\033[1;33m Instale Go Lang en ( *\033[1;33m menu\033[1;32m *\033[1;33m opcion 7 \033[1;32m*\033[1;33m opcion 15 \033[1;32m)"
echo -e "\033[1;33m Debes tener instalado previamente \033[1;32mTrojan Server\033[0m"
echo -e "\033[1;33m IMPORTANTE DEBES TENER LIBRES PUERTOS \033[1;32m7890 / 7891 / 7892 / 9090\033[0m"
echo -e "\033[1;33m Continuar?\033[0m"
unset yesno
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
killall clash 1> /dev/null 2> /dev/null
echo -e "🦎” Cargando Configuracion del Repositorio Original ChumoGH"
fun_bar 'go get -u -v github.com/Dreamacro/clash' # 1> /dev/null 2> /dev/null
clear
echo -e "🦎” Creando Directorios y Archivos"
[[ -d /root/.config ]] && rm -rf /root/.config
mkdir /root/.config 1> /dev/null 2> /dev/null
mkdir /root/.config/clash 1> /dev/null 2> /dev/null
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods. VPSPack      ã€‘\033[0m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
read -p ": " troport
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
#sed -i "s/puertodelservidor/$troport/g" /root/.config/clash/config.yaml
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
    - Trojan🇪🇨_Public🦎_CGH
    #- V2ray🇪🇨_v-2
    #- Trojan🇪🇨_Public2_v-3
    #- Trojan🇪🇨_Public3_v-4
######----- SnellPublic ChumoGH
#######----- Socks  V2rayUC ChumoGH
########----- ShadowsocksPublic ChumoGH
  url: http://www.gstatic.com/generate_204
  interval: 300
 
###################################
# ChumoGH-ADM

# By ChumoGH By CGH
- name: "ServidoresPremiumGratis💢ProhibidaSuVenta"
  type: select
  proxies: 
    - "ChumoGH-ADM"

- name: "Para a entrar a nuestro Team contactar +593987072611 Whatsapp"
  type: select
  proxies:
    - "ChumoGH-ADM"
    
    
rules:
- DOMAIN-SUFFIX,local,ChumoGH-ADM
- DOMAIN-SUFFIX,google.com,ChumoGH-ADM
- DOMAIN-KEYWORD,google,ChumoGH-ADM
- DOMAIN,google.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ad.com,ChumoGH-ADM
- SRC-IP-CIDR,192.168.1.201/32,ChumoGH-ADM
- IP-CIDR,127.0.0.0/8,ChumoGH-ADM
- GEOIP,IR,ChumoGH-ADM
- MATCH, ChumoGH-ADM

proxies:
- name: Trojan🇪🇨_Public🦎_CGH
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
sed -i "s/CGH/$nameperfil/g" /root/.config/clash/config.yaml
#sed -i "s/Trojan_Public2_CGH/$nameperfil/g" /root/.config/clash/config.yaml
echo -e "\033[1;33m Deseas Añadir V2ray si Existe?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
if [[ $(v2ray info | grep TLS) = "TLS: open" ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash de V2RAY"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba el puerto de V2RAY Server Activo"
read -p ": " v2port
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo '
- name: V2ray🇪🇨_v-2
  type: vmess
  server: ipdelservidor
  port: portacces
  mduuid
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  network: ws
  ws-path: /parchetate/
  ws-headers: {Host: sniacces}
' >> /root/.config/clash/config.yaml
#v2rayports=`netstat -tunlp | grep v2ray | grep LISTEN | grep -vE '127.0.0.1' | awk '{print substr($4,4); }' > /tmp/v2.txt && echo | cat /tmp/v2.txt | tr '\n' ' ' > /etc/adm-lite/v2ports.txt && cat /etc/adm-lite/v2ports.txt`;
#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
echo $(v2ray info | grep path |awk -F : '{print $4}') > patch
sed -i 's///c/g' patch
x=$(sed 's/^.//g' patch)
echo $x > patch
s=$(sed 's/.$//g' patch)
echo $s > patch
parche=$(cat < patch)
echo "Ruta pach = "$parche
uid=$(v2ray info | grep UUID)
uid=$(echo $uid |tr [[:upper:]] [[:lower:]])
echo "Habilitando Seleccion en Menu"
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i 's/#- V2ray🇪🇨_v-2/- V2ray🇪🇨_v-2/g' /root/.config/clash/config.yaml
sleep 1
echo "Habilitando IP"
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Nombre en Menu"
sed -i "s/v-2/$nameperfil/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando UUID en V2ray"
sed -i "s/mduuid/$uid/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando SNI del MEtodo"
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Puerto V2ray en Clash"
sed -i "s/portacces/$v2port/g" /root/.config/clash/config.yaml
sleep 1
echo "Habilitando Pach en Clash V2ray"
sed -i "s/parchetate/$parche/g" /root/.config/clash/config.yaml
read -p "V2ray Configurado, Enter to Continued"
else
echo -e "\033[1;31mV2ray no Found 00x3"
fi
fi
unset yesno
echo -e "\033[1;33m Deseas Añadir Trojan Clash 2?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods. VPSPack      ã€‘\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
#echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
#read -p ": " troport
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
unset nameperfil
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
#sed -i "s/puertodelservidor/$troport/g" /root/.config/clash/config.yaml
#sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
#echo -e "\033[1;33mÎ” Escriba el password de Trojan Server"
#read -p ": " tropass
#sed -i "s/clavedelservidor/$tropass/g" /root/.config/clash/config.yaml
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
#sed -i "s/snidelmetodo/$trosni/g" /root/.config/clash/config.yaml
echo -e "Î” Iniciando Servidor"
echo -e '
- name: Trojan🇪🇨_Public2_v-3
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
' >> /root/.config/clash/config.yaml

#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i 's/#- Trojan🇪🇨_Public2_v-3/- Trojan🇪🇨_Public2_v-3/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/v-3/$nameperfil/g" /root/.config/clash/config.yaml
fi
unset yesno
echo -e "\033[1;33m Deseas Añadir Trojan Clash 3?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno
fun_ip
figlet -p -f smslant < /root/name
echo -e "\033[1;37m      ã€      ChumoGH-ADM Mods. VPSPack      ã€‘\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
#echo -e "\033[1;33mÎ” Escriba el puerto de Trojan Server"
#read -p ": " troport
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
unset nameperfil
echo -e "\033[1;33mÎ” Nombre de Su Perfil Clash"
read -p ": " nameperfil
echo -e "\033[1;33mÎ” Escriba Nuevo el SNI de su metodo"
read -p ": " trosni
echo -e '
- name: Trojan🇪🇨_Public3_v-4
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
' >> /root/.config/clash/config.yaml
sed -i 's/#- Trojan🇪🇨_Public3_v-4/- Trojan🇪🇨_Public3_v-4/g' /root/.config/clash/config.yaml
#sed -i 's/#-/-/g' /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$IP/g" /root/.config/clash/config.yaml
sed -i "s/portaaccess/$troport/g" /root/.config/clash/config.yaml
sed -i "s/claveacces/$tropass/g" /root/.config/clash/config.yaml
sed -i "s/sniacces/$trosni/g" /root/.config/clash/config.yaml
sed -i "s/v-4/$nameperfil/g" /root/.config/clash/config.yaml
fi
figlet -p -f smslant < /root/name
echo -e "🦎” \033[1;32mIniciando y Reiniciando Servicio CLASH > Trojan > V2ray"
screen -dmS clashse clash
cp /root/.config/clash/config.yaml /var/www/html/clash.yaml
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mClash Server Instalado"
echo -e "\033[1;32mRuta de Configuracion: /root/.config/clash/config.yaml"
echo -e "\033[1;32mRuta de archivo de importacion de servidor Clash: http://$IP:81/clash.yaml"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
fi
