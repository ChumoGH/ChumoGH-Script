#!/bin/bash
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m++"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100 %\033[1;37m"
}

fun_bar 'apt install cmake -y'
wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badvpn/badvpn-1.999.128.tar.bz2
tar xf badvpn-1.999.128.tar.bz2
#cd badvpn-1.999.128/
cd /etc/adm-lite/badvpn-1.999.128/
cmake /etc/adm-lite/badvpn-1.999.128 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
#cmake ~/badvpn-1.999.128 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
badvpn-udpgw --listen-addr 127.0.0.1:7200 > /dev/nul &
#echo 'badvpn-udpgw --listen-addr 127.0.0.1:7200 > /dev/nul &' >> /etc/rc.local
rm -f badvpn-1.999.128.tar.*
apt-get install cmake -y 1>/dev/null 2>/dev/null
apt-get install screen wget gcc build-essential g++ make -y 1>/dev/null 2>/dev/null
wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badvpn/badvpn-1.999.128.tar.bz2
tar xf badvpn-1.999.128.tar.bz2
cd /etc/adm-lite/badvpn-1.999.128/
cmake ~/badvpn-1.999.128 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
echo "Ejecutando BadVPN en puerto 7300"
badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
rm -f install
echo "Finalizado"
echo "Modulo BadUDP - ChumoGH"
