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
echo -e ' TRANQUILO ESTO DEMORARA UN POCO, MIENTRAS ACTULIZAMOS!!'
fun_bar 'apt-get update -y' 'apt-get upgrade -y'
update1='aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0NodW1vR0gvQ2h1bW9HSC1TY3JpcHQvbWFzdGVyL2NnaC5zaA=='
dom='base64 -d'
RE=$(echo $update1|$dom)
wget -O cgh.sh $RE;chmod 777 cgh.sh* && ./cgh.sh*
