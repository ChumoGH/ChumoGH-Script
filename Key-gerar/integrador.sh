#!/bin/bash
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
SCPresq="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0NodW1vR0gvY2h1bW9naC1nbWFpbC5jb20vbWFzdGVyLw=="
#"https://raw.githubusercontent.com/ChumoGH/chumogh-gmail.com/master/"
#"aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0FBQUFBRVhRT1N5SXBOMkpaMGVoVVEvUFJPWUVDVE9TX0RFU0NPTlRJTlVBRE9TL21hc3Rlci9HRU5FUkFET1ItTkVXLVVMVElNQVRFLU9SSUdJTkFML2dlcmFkb3I="
SUB_DOM='base64 -d'
rm $(pwd)/$0
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"3")txt[$i]="%";;
"%")txt[$i]="3";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
veryfy_fun () {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
unset ARQ
case $1 in
"gerar.sh")ARQ="/usr/bin/";;
"http-server.py")ARQ="/bin/";;
*)ARQ="${SCPT_DIR}/";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
meu_ip
echo -e "\033[1;33mInstalando Arquivos... "
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
cd $HOME
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}/lista > /dev/null 2>&1
#########################
[[ -e $HOME/lista-arq ]] && {
[[ -d /etc/SCRIPT ]] && rm -rf /etc/SCRIPT
mkdir /etc/SCRIPT
cd /etc/SCRIPT
touch /etc/SCRIPT/index.html
wget -i ${REQUEST}/lista -o /dev/null
mv -f gerar.sh /usr/bin/
chmod +x /usr/bin/gerar.sh
mv -f http-server.py /bin/
chmod +x /bin/http-server.py
echo -e "\033[1;31m- \033[1;32mRecebido Com Sucesso!"
cd /etc/SCRIPT
chmod +x ./*
} || echo -e "\033[1;31m- \033[1;31mFalha (nao recebido!)"
done


################


sleep 1s

[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/GENERADOR-NEW-ULTIMATE-ORIGINAL/Install/trans &> /dev/null
[[ -e /bin/http-server.py ]] && mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR2
rm $HOME/lista-arq
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo "/usr/bin/gerar.sh" > /usr/bin/gerar && chmod +x /usr/bin/gerar
echo -e "\033[1;33m Perfeito, Use o Comando \033[1;31mgerar.sh o gerar \033[1;33mpara Gerenciar as Suas Keys e
 Atualizar a Base do servidor"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
} || {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey Invalida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
}
echo -ne "\033[0m"
echo "qra-atsilK?29@%6087%?66d5K8888:%05+08+@@?+91" > /etc/key-gerador
apt-get install netcat -y &>/dev/null
