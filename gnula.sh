#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH

echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
reiniciar_ser () {
echo -ne " \033[1;31m[ ! ] Services BadVPN and Netflix restart"
kill -9 $(ps x | grep badvpn | grep -v grep | awk '{print $1'}) > /dev/null 2>&1
killall badvpn-udpgw > /dev/null 2>&1
unset pid_badvpn
[[ -e /bin/badvpn-udpgw ]] && screen -dmS screen /bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10 > /dev/null 2>&1 && bash <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/netflix.sh) > /dev/null && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
pid_badvpn=$(ps x | grep badvpn | grep -v grep | awk '{print $1}')
##
echo -ne " \033[1;31m[ ! ] Services ssh restart"
service ssh restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services stunnel4 restart"
service stunnel4 restart > /dev/null 2>&1
[[ -e /etc/init.d/stunnel4 ]] && /etc/init.d/stunnel4 restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services V2RAY restart"
service v2ray restart > /dev/null 2>&1
[[ -e /etc/v2ray/config.json ]] && v2ray restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services V2-UI restart"
v2-ui restart > /dev/null 2>&1
[[ -e /usr/local/v2-ui/bin/config.json ]] && v2-ui restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services squid restart"
service squid restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services squid3 restart"
service squid3 restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services apache2 restart"
service apache2 restart > /dev/null 2>&1
[[ -e /etc/init.d/apache2 ]] && /etc/init.d/apache2 restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services openvpn restart"
service openvpn restart > /dev/null 2>&1
[[ -e /etc/init.d/openvpn ]] && /etc/init.d/openvpn restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services dropbear restart"
service dropbear restart > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && /etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services Trojan restart"
killall trojan &> /dev/null 2>&1
[[ -e /usr/local/etc/trojan/config.json ]] && screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services Clash for Android restart"
killall clash &> /dev/null 2>&1
[[ -e /root/.config/clash/config.yaml ]] && screen -dmS clashse /root/.config/clash/clash > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services fail2ban restart"
( 
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart
fail2ban-client -x stop && fail2ban-client -x start
) > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
return
}

sudo sync
sudo sysctl -w vm.drop_caches=3
sysctl -w vm.drop_caches=3 > /dev/null 2>&1
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
rm -rf /tmp/*
sudo apt autoremove -y
sudo apt purge & sudo apt clean 
sudo rm /var/lib/apt/lists/lock && sudo rm /var/cache/apt/archives/lock && sudo rm /var/lib/dpkg/lock
tiempo=$(printf '%(%D-%H:%M:%S)T') 
echo $tiempo >> /tmp/dropcache
reiniciar_ser >> /root/lm.log
echo -e >> $HOME/lm.log
echo "Limpio >" $tiempo >> /root/lm.log
killall bash

