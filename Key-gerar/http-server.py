#!/bin/bash
IVAR="/etc/http-instas"
install_fun () {
apt-get install netcat -y
}
fun_ip () {
_hora=$(printf '%(%D-%H:%M:%S)T')
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

#OFUSCATE
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

# LISTEN
listen_fun () {
PORTA="8888"
PROGRAMA="/bin/http-server.sh"
while true; do
 nc.traditional -l -p "$PORTA" -e "$PROGRAMA"
done
}
# SERVER
server_fun () {
DIR="/etc/http-shell"
unset ENV_ARQ
if [[ ! -d $DIR ]]; then
mkdir $DIR
fi
read URL
KEYZ=($(echo $URL|cut -d ' ' -f2|awk -F "/" '{print $2, $3, $4, $5, $6, $7}'))
KEY=$(echo ${KEYZ[0]}) && [[ ! $KEY ]] && KEY="ERRO"
ARQ=$(echo ${KEYZ[1]}) && [[ ! $ARQ ]] && ARQ="ERRO"
USRIP=$(echo ${KEYZ[2]}) && [[ ! $USRIP ]] && USRIP="ERRO"
FILE2="${DIR}/${KEY}"
FILE="${DIR}/${KEY}/$ARQ"
if [[ -e ${FILE} ]]; then
STATUS_NUMBER="200"
STATUS_NAME="Found"
ENV_ARQ="True"
 if [[ -e ${FILE2}/FERRAMENTA ]]; then
   if [[ ${USRIP} != "ERRO" ]]; then
    FILE="${DIR}/ERROR-KEY"
    echo "FERRAMENTA KEY!" > ${FILE}
    ENV_ARQ="False"
   fi
 else
   if [[ ${USRIP} = "ERRO" ]]; then
    FILE="${DIR}/ERROR-KEY"
    echo "KEY DE INSTALAÇAO!" > ${FILE}
    ENV_ARQ="False"
   fi
 fi
else
FILE="${DIR}/ERROR-KEY"
echo "KEY INVALIDA!" > ${FILE} 
STATUS_NUMBER="200"
STATUS_NAME="Found"
ENV_ARQ="False"
fi
cat << EOF
HTTP/1.1 $STATUS_NUMBER - $STATUS_NAME
Date: $(date)
Server: ShellHTTP
Content-Length: $(wc --bytes "$FILE" | cut -d " " -f1)
Connection: close
Content-Type: text/html; charset=utf-8

$(cat "$FILE")
EOF
if [[ $ENV_ARQ = "True" ]]; then
(
mkdir /var/www/html/$KEY
mkdir /var/www/$KEY
TIME="10+"
  for arqs in `cat $FILE`; do
  cp ${FILE2}/$arqs /var/www/html/$KEY/
  cp ${FILE2}/$arqs /var/www/$KEY/
  TIME+="1+"
  done
TIME=$(echo "${TIME}0"|bc)
sleep ${TIME}s
rm -rf /var/www/html/$KEY
rm -rf /var/www/$KEY
log="/etc/gerar-sh-log"
if [[ -d $FILE2 ]]; then
PERM="${DIR}/${KEY}/keyfixa" 
if [[ -e $PERM ]]; then
  if [[ $(cat $PERM) != "$USRIP" ]]; then
  log="/etc/gerar-sh-log"
  echo "USUARIO: $(cat ${FILE2}.name) IP FIJA: $(cat $PERM) SU IP: $USRIP" >> $log
  echo "SU KEY FIJA FUE BLOQUEADA" >> $log
  echo "--------------------------------------------------------------------" >> $log
  rm -rf "$FILE2"
  rm "${FILE2}.name"
  fi
else
fun_ip
_hora=$(printf '%(%D-%H:%M:%S)T') 
echo "\033[0;34mUSUARIO: \033[0;31m$(cat ${FILE2}.name) \033[0;36mSU IP:\033[0;33m $USRIP" >> $log
echo "\033[0;36mKey \033[0;33m"$(ofus "$IP:8888/$KEY/lista-arq") >> $log
echo "\033[0;31mKey Fue Usada >\033[0;32m" $_hora  >> $log
echo "\033[0;33m--------------------------------------------------------------------" >> $log
rm -rf "$FILE2"
rm "${FILE2}.name"
fi
num=$(cat ${IVAR})
 if [[ $num = "" ]]; then
 num=0
 fi
let num++
echo $num > $IVAR
fi
) & > /dev/null
fi
}

[[ $1 = @(-[Ss]tart|-[Ss]|-[Ii]niciar) ]] && listen_fun && exit
[[ $1 = @(-[Ii]stall|-[Ii]|-[Ii]stalar) ]] && listen_fun && exit
server_fun
