#!/bin/bash
#19/12/2019
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
BadVPN () {
pid_badvpn=$(ps x | grep badvpn | grep -v grep | awk '{print $1}')
if [ "$pid_badvpn" = "" ]; then
    msg -ama "                   ACTIVANDO BADVPN"
    msg -bar 
    if [[ ! -e /bin/badvpn-udpgw ]]; then
    wget -O /bin/badvpn-udpgw https://raw.githubusercontent.com/rudi9999/VPS-MX-8.0/master/ArchivosUtilitarios/badvpn-udpgw &>/dev/null
    chmod 777 /bin/badvpn-udpgw
    fi
    screen -dmS badvpn2 /bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10 
    [[ "$(ps x | grep badvpn | grep -v grep | awk '{print $1}')" ]] && msg -verd "                  ACTIVADO CON EXITO" || msg -ama "                 Fallo"
	msg -bar
    echo -ne "\033[1;97m activar BADVPN-(UDP:7300) despues de un reinicio [s/n]: "
    read ini_udpg
    [[ $ini_udpg = @(s|S|y|Y) ]] && {
        crontab -l > /root/cron
        echo '@reboot screen -dmS badvpn2 /bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10' >> /root/cron
        crontab /root/cron
        rm /root/cron
    }
    msg -bar
else
    msg -ama "                DESACTIVANDO BADVPN"
    msg -bar
    crontab -l > /root/cron
    sed -i '/badvpn/ d' /root/cron
    crontab /root/cron
    rm /root/cron
    kill -9 $(ps x | grep badvpn | grep -v grep | awk '{print $1'}) > /dev/null 2>&1
    killall badvpn-udpgw > /dev/null 2>&1
    [[ ! "$(ps x | grep badvpn | grep -v grep | awk '{print $1}')" ]] && msg -ne "                DESACTIVADO CON EXITO \n"
    unset pid_badvpn
	msg -bar
    fi
unset pid_badvpn
}

BadVPN
