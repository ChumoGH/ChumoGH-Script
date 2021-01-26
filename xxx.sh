#!/bin/bash
function printTitle
{
    echo ""
    echo -e "\033[1;92m$1\033[1;91m"
    printf '%0.s-' $(seq 1 ${#1})
    echo ""
}
killall apt apt-get &> /dev/null
TIME_START="$(date +%s)"
DOWEEK="$(date +'%u')"
[[ -e $HOME/cgh.sh ]] && rm $HOME/cgh.*
dpkg --configure -a
fun_bar3 () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m☻"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[1;31m♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
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
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m✯"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
}

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
unset Key
echo -ne " \033[1;31m[ ! ]  TRANQUILO ESTO DEMORARA UN POCO, MIENTRAS ACTULIZAMOS!!  [ ! ]"
echo -e ' '
#fun_bar1 'apt-add-repository universe -y'
fun_bar1
#echo -e ' '
#fun_bar1 'sudo add-apt-repository ppa:neurobin/ppa'
echo -ne " \033[1;31m[ ! ] apt-get update"
apt-get update -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] apt-get upgrade"
apt-get upgrade -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] apt-get Repositorios Universales"
apt-get install software-properties-common -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -e 'Listo!!! TERMINAMOS DE ACTUALIZAR TODOS LOS REPOSITORIOS'
return
}
clear
update_pak
update1='aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0NodW1vR0gvQ2h1bW9HSC1TY3JpcHQvbWFzdGVyL2NnaC5zaA=='
dom='base64 -d'
RE=$(echo $update1|$dom)
sleep 2s
clear
wget -q -O cgh.sh $RE;chmod +x cgh.sh && ./cgh.sh
rm -f instala.*
rm -f cgh.*
printTitle "Duracion de Uso del Instalador ADM"
echo -e "   Ejecucion de  $((($(date +%s)-$TIME_START)/60)) min."
read -p "Presiona Enter para Continuar"
[[ -e /etc/adm-lite/menu ]] && cgh
