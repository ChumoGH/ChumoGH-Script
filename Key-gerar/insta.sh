#!/bin/bash
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
[[ -d $SCPT_DIR ]] && rm -rf $SCPT_DIR
SCPresq="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0NodW1vR0gvY2h1bW9naC1nbWFpbC5jb20vbWFzdGVyLw=="
SUB_DOM='base64 -d'

#CORES
cor[1]="\033[1;36m"
cor[2]="\033[1;32m"
cor[3]="\033[1;31m"
cor[4]="\033[1;33m"
cor[0]="\033[1;37m"
fun_bar1 () {
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
echo -ne "\033[1;31m≛"
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
update_pak () {
echo -ne " \033[1;31m[ ! ]  TRANQUILO ESTO DEMORARA UN POCO, MIENTRAS ACTULIZAMOS!!  [ ! ]"
echo -e ' '
fun_bar1 'apt-add-repository universe -y'
echo -e ' '
fun_bar1 'sudo add-apt-repository ppa:neurobin/ppa'
echo -ne " \033[1;31m[ ! ] apt-get update"
apt-get update -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] apt-get upgrade"
apt-get upgrade -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] apt-get Repositorios Universales"
apt-get install software-properties-common -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -e 'Listo!!! TERMINAMOS DE ACTUALIZAR TODOS LOS REPOSITORIOS'
clear
return
}
clear
update_pak
#TEXTOS
txt[206]="Archivito(s) Actualizado(s)!"
txt[208]="Invalid Key, Contact the Script Admin!"
txt[207]="Valid!!!"
txt[203]="☹"
txt[204]="㋡--->"
txt[205]="Actualizado"

#COMPARA
fun_filez () {
arq="/etc/SCRIPT/$1"
arq2="$HOME/update/$1"
     [[ ! -e "/etc/SCRIPT/$1" ]] && {
     mv -f $arq2 $arq
     unset ARQ
     case $1 in
     "gerar.sh")ARQ="/usr/bin/";;
     "http-server.py")ARQ="/bin/";;
      esac
     mv -f $arq2 ${ARQ}/$1
     chmod +x ${ARQ}/$1
     return
     }
equal=$(diff -q $arq $arq2)
echo -e "\033[1;31m ${txt[203]}: $1"
     [[ "$equal" = "" ]] && rm $arq2 || {
     mv -f $arq2 $arq
     chmod +x $arq
     unset ARQ
     case $1 in
     "gerar.sh")ARQ="/usr/bin/";;
     "http-server.py")ARQ="/bin/";;
      esac
     mv -f $arq2 ${ARQ}/$1
     chmod +x ${ARQ}/$1
     lista_atualizados=$(($lista_atualizados + 1))
     echo -e "\033[1;32m ${txt[204]}: $1 - ${txt[205]}!"
     sleep 0.5s
     echo ""
     }
}
clear
rm $(pwd)/$0 > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mExito!" || echo -e "\033[1;31m- \033[1;31mFallo"
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

atualiza_fun () {
echo -e "${cor[1]} =================================== ${cor[0]}"
cd $HOME
[[ ! -d ./update ]] && mkdir ./update
cd ./update
wget -i $HOME/lista -o /dev/null  
unset arqs
for arqs in `ls $HOME/update`; do
echo -ne "\033[1;33mDescargando archivo: \033[1;31m[$arqs] "
fun_filez $arqs > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mRecibido con éxito!" || echo -e "\033[1;31m- \033[1;31mFalla (no recibido!)"
done
cd $SCPT_DIR
wget -O lista https://raw.githubusercontent.com/ChumoGH/chumogh-gmail.com/master/lista -o /dev/null
cat http-server.py > /bin/http-server.py
chmod +x /bin/http-server.py
cp gerar.sh /usr/bin/gerar.sh
chmod +x /usr/bin/gerar.sh
cd $HOME
  [[ -e $HOME/lista ]] && rm $HOME/lista
  [[ -d $HOME/update ]] && rm -rf $HOME/update
[[ "$lista_atualizados" != "" ]] && echo -e "${cor[5]} $lista_atualizados ${txt[206]}"
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
echo -e "\033[1;36m--------------------KEY GENERATOR BY ChumoGH ADM----------------------\033[0m"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
read -p "INTRODUZCA SU KEY DE INSTALACIÓN: " Key
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
[[ ! $Key ]] && {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey inválida! llamame "
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
exit
}
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
meu_ip
echo -e "\033[1;33mVerificando key... "
cd $HOME
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}lista > /dev/null 2>&1
sleep 1s
[[ -e $HOME/lista-arq ]] && {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
#unset ARQ
#mkdir $SCPT_DIR
#cd $SCPT_DIR
#touch $SCPT_DIR/index.html
#wget -i ${REQUEST}/lista -o /dev/null
#mv -f gerar.sh /usr/bin/
#chmod +x /usr/bin/gerar.sh
#mv -f http-server.py /bin/
#chmod +x /bin/http-server.py
cd 
wget -O lista https://raw.githubusercontent.com/ChumoGH/chumogh-gmail.com/master/lista -o /dev/null
atualiza_fun
echo -e "\033[1;31m- \033[1;32mRecebido Com Sucesso!"
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://www.dropbox.com/s/l6iqf5xjtjmpdx5/trans?dl=0 &> /dev/null
mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
apt-get install bc -y &>/dev/null
apt-get install screen -y &>/dev/null
apt-get install nano -y &>/dev/null
apt-get install curl -y &>/dev/null
apt-get install netcat -y &>/dev/null
apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR2
echo $Key > /etc/http-instas
rm $HOME/lista-arq
echo "source <(curl -sL https://raw.githubusercontent.com/ChumoGH/russ/master/Key-gerar/gerar.sh)" > /usr/bin/gerar && chmod +x /usr/bin/gerar
echo -e "\033[1;33m Perfecto, utilize el comando \033[1;31mgerar.sh o gerar \033[1;33mpara administrar sus keys y
 actualizar la base del servidor"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey ACCESIBLE!" $1

echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
} || {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey inválida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
}
echo "qra-atsilK?29@%6087%?66d5K8888:%05+08+@@?+91" > /etc/key-gerador
apt-get install netcat -y &>/dev/null
echo -ne "\033[0m"1
