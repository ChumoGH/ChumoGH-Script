#!/bin/bash
#19/05/2020
clear
msg -bar
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
apt-get install python -y > /dev/null 2>&1
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}
meu_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
}
tcpbypass_fun () {
[[ -e $HOME/socks ]] && rm -rf $HOME/socks > /dev/null 2>&1
[[ -d $HOME/socks ]] && rm -rf $HOME/socks > /dev/null 2>&1
cd $HOME && mkdir socks > /dev/null 2>&1
cd socks
patch="https://raw.githubusercontent.com/rudi9999/VPS-MX-8.0/master/ArchivosUtilitarios/backsocz"
arq="backsocz"
wget $patch -o /dev/null
unzip $arq > /dev/null 2>&1
mv -f ./ssh /etc/ssh/sshd_config && service ssh restart 1> /dev/null 2>/dev/null
mv -f sckt$(python3 --version|awk '{print $2}'|cut -d'.' -f1,2) /usr/sbin/sckt
mv -f scktcheck /bin/scktcheck
chmod +x /bin/scktcheck
chmod +x  /usr/sbin/sckt
rm -rf $HOME/socks
cd $HOME
msg="$2"
[[ $msg = "" ]] && msg="@Rufu99"
portxz="$1"
[[ $portxz = "" ]] && portxz="8080"
screen -dmS sokz scktcheck "$portxz" "$msg" > /dev/null 2>&1
}
gettunel_fun () {
echo "master=NetVPS" > ${SCPinst}/pwd.pwd
while read service; do
[[ -z $service ]] && break
echo "127.0.0.1:$(echo $service|cut -d' ' -f2)=$(echo $service|cut -d' ' -f1)" >> ${SCPinst}/pwd.pwd
done <<< "$(mportas)"
screen -dmS getpy python ${SCPinst}/PGet.py -b "0.0.0.0:$1" -p "${SCPinst}/pwd.pwd"
 [[ "$(ps x | grep "PGet.py" | grep -v "grep" | awk -F "pts" '{print $1}')" ]] && {
 echo -e "$(fun_trans  "Gettunel Iniciado com Sucesso")"
 msg -bar
 echo -ne "$(fun_trans  "Sua Senha Gettunel e"):"
 echo -e "\033[1;32m NetVPS"
 msg -bar
 } || echo -e "$(fun_trans  "Gettunel nao foi iniciado")"
 msg -bar
}

PythonDic_fun () {
echo -e "\033[1;97m Selecciona Puerto Local\033[1;37m" 
msg -bar
echo -ne "\033[1;97m Digite Un Puerto SSH/DROPBEAR activo: \033[1;37m" && read puetoantla 
msg -bar
echo -ne "\033[1;97m Ejcutar python directo despues de un reinicio [s/n]: "
read start_cron
msg -bar
[[ $start_cron = @(s|S|y|Y) ]] && {
	crontab -l > /root/cron
	echo "@reboot ${SCPinst}/Proxy.sh -p "$porta_socket" -pl "$puetoantla" -tc \""$texto_soket"\" --start" >> /root/cron
	crontab /root/cron
	rm /root/cron
}
texto="$(echo ${texto_soket} | sed 's/\"//g')"
${SCPinst}/Proxy.sh -p "$porta_socket" -pl "$puetoantla" -tc "$texto" -s && echo ""$porta_socket" "$texto_soket"" >> /etc/newadm/PortPD.log
}

pid_kill () {
[[ -z $1 ]] && refurn 1
pids="$@"
for pid in $(echo $pids); do
kill -9 $pid &>/dev/null
done
}
remove_fun () {
echo -e "$(fun_trans  "Parando Socks Python")"
msg -bar
pidproxy=$(ps x | grep "PPub.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy ]] && pid_kill $pidproxy
pidproxy2=$(ps x | grep "PPriv.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy2 ]] && pid_kill $pidproxy2
#pidproxy3=$(ps x | grep "PDirect.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy3 ]] && pid_kill $pidproxy3
pidproxy4=$(ps x | grep "POpen.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy4 ]] && pid_kill $pidproxy4
pidproxy5=$(ps x | grep "PGet.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy5 ]] && pid_kill $pidproxy5
pidproxy6=$(ps x | grep "scktcheck" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy6 ]] && pid_kill $pidproxy6

pidproxy3=$(ps x | grep "python -x" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy3 ]] && pid_kill $pidproxy3
crontab -l > /root/cron
sed -i '/Proxy.sh/ d' /root/cron
crontab /root/cron
rm /root/cron

echo -e "\033[1;91m  $(fun_trans  "Socks DETENIDOS")"
msg -bar
rm -rf /etc/newadm/PortPD.log
echo "" > /etc/newadm/PortPD.log
exit 0
}
iniciarsocks () {
pidproxy=$(ps x | grep -w "PPub.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy ]] && P1="\033[1;32m[ON]" || P1="\033[1;31m[OFF]"
pidproxy2=$(ps x | grep -w  "PPriv.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy2 ]] && P2="\033[1;32m[ON]" || P2="\033[1;31m[OFF]"
#pidproxy3=$(ps x | grep -w  "PDirect.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy3 ]] && P3="\033[1;32m[ON]" || P3="\033[1;31m[OFF]"
pidproxy3=$(ps x | grep -w  "python -x" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy3 ]] && P3="\033[1;32m[ON]" || P3="\033[1;31m[OFF]"
pidproxy4=$(ps x | grep -w  "POpen.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy4 ]] && P4="\033[1;32m[ON]" || P4="\033[1;31m[OFF]"
pidproxy5=$(ps x | grep "PGet.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy5 ]] && P5="\033[1;32m[ON]" || P5="\033[1;31m[OFF]"
pidproxy6=$(ps x | grep "scktcheck" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy6 ]] && P6="\033[1;32m[ON]" || P6="\033[1;31m[OFF]"
echo -e "\033[1;32m $(fun_trans  "INSTALADOR SOCKS SPIDER-VPS By MOD @Rufu99")"
msg -bar
echo -e "${cor[4]} [1] > \033[1;36m$(fun_trans  "Socks Python SIMPLE")      $P1"
echo -e "${cor[4]} [2] > \033[1;36m$(fun_trans  "Socks Python SEGURO")      $P2"
echo -e "${cor[4]} [3] > \033[1;36m$(fun_trans  "Socks Python DIRETO") [PC] $P3"
echo -e "${cor[4]} [4] > \033[1;36m$(fun_trans  "Socks Python OPENVPN")     $P4"
echo -e "${cor[4]} [5] > \033[1;36m$(fun_trans  "Socks Python GETTUNEL")    $P5"
echo -e "${cor[4]} [6] > \033[1;36m$(fun_trans  "Socks Python TCP BYPASS")  $P6"
echo -e "${cor[4]} [7] > \033[1;36m$(fun_trans  "PARAR TODOS SOCKS PYTHON")"
echo -e "${cor[4]} [0] > \033[1;37m$(fun_trans  "VOLVER")"
msg -bar
IP=(meu_ip)
while [[ -z $portproxy || $portproxy != @(0|[1-7]) ]]; do
echo -ne "$(fun_trans  "Digite Una Opcion"): \033[1;37m" && read portproxy
tput cuu1 && tput dl1
done
 case $portproxy in
    7)remove_fun;;
    0)return;;
 esac
echo -e "\033[1;97m Selecciona Puerto Principal del Proxy"
msg -bar
porta_socket=
while [[ -z $porta_socket || ! -z $(mportas|grep -w $porta_socket) ]]; do
echo -ne "\033[1;97m Digite el Puerto: \033[1;37m" && read porta_socket
tput cuu1 && tput dl1
done
echo -e "$(fun_trans  "       Introdusca su Mini-Banner")"
msg -bar
echo -ne "\033[1;97m Introduzca un texto [Plano] o en [HTML]\n\n \033[1;37m" && read texto_soket
    msg -bar
    case $portproxy in
    1)screen -dmS screen python ${SCPinst}/PPub.py "$porta_socket" "$texto_soket";;
    2)screen -dmS screen python3 ${SCPinst}/PPriv.py "$porta_socket" "$texto_soket" "$IP";;
    3)PythonDic_fun;;
    4)screen -dmS screen python ${SCPinst}/POpen.py "$porta_socket" "$texto_soket";;
    5)gettunel_fun "$porta_socket";;
    6)tcpbypass_fun "$porta_socket" "$texto_soket";;
    esac
echo -e "\033[1;92m$(fun_trans " Procedimiento COMPLETO")"
msg -bar
}
iniciarsocks
