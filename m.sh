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
echo -e "\033[1;33m]\033[1;37m -\033[1;32m EXITO !\033[1;37m"
tput cnorm
}

ssl_redir() {
echo "Asigne un nombre para el redirecionador"
echo "Es decir un puerto abierto en su servidor"
echo "ejemplo: openvpn,shadowsocks,dropbear etc..."
fun_bar
read -p " Local-Port: " portd
echo "Que puerto desea agregar como SSL"
    while true; do
    read -p " Puerto SSL: " SSLPORTr
    [[ $(mportas|grep -w "$SSLPORTr") ]] || break
    echo -e "esta puerta está en uso"
    unset SSLPORT1
    done
echo "Instalando SSL"
fun_bar "apt-get install stunnel4"
echo "Presione Enter a todas las opciones"
sleep 2
fun_bar
openssl genrsa 1024 > stunnel.key
openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt
cat stunnel.crt stunnel.key > stunnel.pem
mv stunnel.pem /etc/stunnel/

echo "client = no" >> /etc/stunnel/stunnel.conf
echo "[${namer}]" >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem" >> /etc/stunnel/stunnel.conf
echo "accept = ${SSLPORTr}" >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:${portd}" >> /etc/stunnel/stunnel.conf
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\033[1;31mPARA SALIR DEL PANEL PRESIONE CTLR+C \e[0m"
sleep 5s
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
service stunnel4 restart > /dev/null 2>&1
echo  "AGREGADO CON EXITO"
}

ssl_redir
