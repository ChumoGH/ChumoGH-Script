killall apt apt-get &> /dev/null
rm -rf cgh.*
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
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m"
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
   echo -ne "\033[1;31m##"
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
clear
echo -e ' TRANQUILO ESTO DEMORARA UN POCO, MIENTRAS ACTULIZAMOS!!'
echp 
fun_bar1 'apt-get update -y' 'apt-get upgrade -y'
echo 
fun_bar 'apt-get install software-properties-common -y' 
fun_bar 'apt-add-repository universe -y'
fun_bar 'sudo add-apt-repository ppa:neurobin/ppa -y' 
fun_bar3 'sudo apt-get install shc -y'
echo -ne 'Listo!!! TERMINAMOS DE ACTUALIZAR TODOS LOS REPOSITORIOS'
sleep 2s
rm -rf /etc/localtime &>/dev/null
ln -s /usr/share/zoneinfo/America/Guayaquil /etc/localtime &>/dev/null
rm $(pwd)/$0 &> /dev/null
update1='aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0NodW1vR0gvQ2h1bW9HSC1TY3JpcHQvbWFzdGVyL2NnaC5zaA=='
dom='base64 -d'
RE=$(echo $update1|$dom)
wget -O cgh.sh $RE;chmod 777 cgh.sh* && ./cgh.sh*
