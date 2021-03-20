#!/bin/bash
# INSTALACAO BASICA
clear
#[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ADMbot.sh C-SSR.sh Crear-Demo.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py Shadowsocks-R.sh Shadowsocks-libev.sh Unlock-Pass-VULTR.sh apacheon.sh blockBT.sh budp.sh dns-netflix.sh   dropbear.sh fai2ban.sh gestor.sh menu message.txt openvpn.sh  ports.sh shadowsocks.sh sockspy.sh speed.sh speedtest.py squid.sh squidpass.sh ssl.sh tcp.sh ultrahost usercodes utils.sh v2ray.sh Proxy.sh"
[[ -e /etc/newadm-instalacao ]] &&  BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ferramentas limitera menu_inst PPub.py speedtest.py usercodes ferramentascodes limiterb  menu-txt payloads ssl user-txt cabecalho ferramentas-txt limiter.sh trans verifica confdropbear get PDirect.py v-local.log idioma_geral MasterBin.sh PGet.py pwd.pwd ultrahost idioma_menuinst menu optimizador POpen.py shadowsocks.sh fai2ban menu_credito PPriv.py user"
IVAR="/etc/http-instas"
BARRA="\033[1;36m-----------------------------------------------------\033[0m"
BARRA2="\033[1;31m=====================================================\033[0m"
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(printf '%(%D)T') 

#PROCESSADOR
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

#SISTEMA-USO DA CPU-MEMORIA RAM
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})

_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")

# Funcoes Globais
msg () {
local colors="/etc/new-adm-color"
if [[ ! -e $colors ]]; then
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[91m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
COLOR[7]='\033[1;49;95m'
COLOR[8]='\033[1;49;96m'
else
local COL=0
for number in $(cat $colors); do
case $number in
1)COLOR[$COL]='\033[1;37m';;
2)COLOR[$COL]='\e[31m';;
3)COLOR[$COL]='\e[32m';;
4)COLOR[$COL]='\e[33m';;
5)COLOR[$COL]='\e[34m';;
6)COLOR[$COL]='\e[35m';;
7)COLOR[$COL]='\033[1;36m';;
8)COLOR[$COL]='\033[1;49;95m';;
9)COLOR[$COL]='\033[1;49;96m';;
esac
let COL++
done
fi
NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${COLOR[1]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${COLOR[3]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm2)cor="${COLOR[1]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -aqua)cor="${COLOR[8]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${COLOR[6]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${COLOR[2]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${COLOR[0]}${SEMCOR}" && echo -e "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${COLOR[7]}=====================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}

os_system () {
system=$(echo $(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //'))
echo $system|awk '{print $1, $2}'
}

meu_ipe () {
#if [[ -e /etc/MEUIPADM ]]; then
#echo "$(cat /etc/MEUIPADM)"
#else
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ -z "$MEU_IP2" ]] && MEU_IP2=127.0.0.1
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
echo "$MEU_IP2" > /etc/MEUIPADM
#fi
}

ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
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


SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
INSTA_ARQUIVOS="ADMVPS.zip"
DIR="/etc/http-shell"
LIST="lista-arq"
P_SERVER="https://www.dropbox.com/s/blxo0jifysvyrey/"
v1=$(curl -sSL "${P_SERVER}/v-new.log")
v2=$(cat $SCPT_DIR/v-local.log)
txt[315]="💥 ChumoGH Keygen 💥 IS UPDATED!"
txt[316]="⚠️ ChumoGH Keygen ⚠️ NEEDS UPDATE!"
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ -z "$MIP2" ]] && MIP2=127.0.0.1
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

mudar_instacao () {
while [[ ${var[$value]} != 0 ]]; do
#[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ADMbot.sh C-SSR.sh Crear-Demo.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py Shadowsocks-R.sh Shadowsocks-libev.sh Unlock-Pass-VULTR.sh apacheon.sh blockBT.sh budp.sh dns-netflix.sh   dropbear.sh fai2ban.sh gestor.sh menu message.txt openvpn.sh ports.sh shadowsocks.sh sockspy.sh speed.sh speedtest.py squid.sh squidpass.sh ssl.sh tcp.sh ultrahost usercodes utils.sh v2ray.sh Proxy.sh"
[[ -e /etc/newadm-instalacao ]] &&  BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ferramentas limitera menu_inst PPub.py speedtest.py usercodes ferramentascodes limiterb  menu-txt payloads ssl user-txt cabecalho ferramentas-txt limiter.sh trans verifica confdropbear get PDirect.py v-local.log idioma_geral MasterBin.sh PGet.py pwd.pwd ultrahost idioma_menuinst menu optimizador POpen.py shadowsocks.sh fai2ban menu_credito PPriv.py user"
msg -bar
echo -e "MENÚ SELECCIÓN DE INSTALACIÓN"
msg -bar
i=1
for arqx in `ls ${SCPT_DIR}`; do
[[ $arqx = @(gerar.sh|http-server.py) ]] && continue
[[ $(echo $BASICINST|grep -w "$arqx") ]] && echo -e "\033[1;32m[$i] \033[1;37m- [\033[1;31mX\033[1;37m] - \033[1;96m$arqx" || echo -e "\033[1;32m[$i] \033[1;37m- [ ] - \033[1;96m$arqx"
var[$i]="$arqx"
let i++
done
msg -bar
echo "[0] - FINALIZAR PROCEDIMIENTO"
msg -bar
echo -ne "Seleccione el archivo [Agregar / Eliminar]: "
read value
[[ -z ${var[$value]} ]] && return
if [[ $(echo $BASICINST|grep -w "${var[$value]}") ]]; then
rm /etc/newadm-instalacao
local BASIC=""
  for INSTS in $(echo $BASICINST); do
  [[ $INSTS = "${var[$value]}" ]] && continue
  BASIC+="$INSTS "
  done
echo $BASIC > /etc/newadm-instalacao
else
echo "$BASICINST ${var[$value]}" > /etc/newadm-instalacao
fi
done
}



gen_key_menu () {
if [[ $1 = 1 ]]; then
		#ADM BASIC
		[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
		read -p "Nombre de usuario ( comprador de la key ): " nombrevalue
		[[ -z $nombrevalue ]] && nombrevalue="SIN NOMBRE"
 		arqslist="$BASICINST"
		 for arqx in `echo "${arqslist}"`; do
			[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
			cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
			echo "$arqx" >> ${DIR}/${KEY}/${LIST}
		 done
		 echo "$nombrevalue" > ${DIR}/${KEY}.name
		 [[ -e /etc/gen_at.txt ]] && at now +$(cat /etc/gen_at.txt) <<< "rm -rf ${DIR}/${KEY}.name; rm -rf ${DIR}/${KEY}" &>/dev/null
		 tipo="ADM"
		 linck=1
		 key_ok
elif [[ $1 = 3 ]]; then
		# GERADOR KEYS
		[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
		read -p "Nombre de usuario ( comprador de la key ): " nombrevalue
		[[ -z $nombrevalue ]] && nombrevalue="SIN NOMBRE"
		msg -bar
		read -p "autorizar a generar key para generador [Y/N]: " -e -i n gen_gen
		msg -bar
		read -p "KEY DE ACTUALIZACIÓN?: [Y/N]: " -e -i n attGEN
		[[ $(echo $nombrevalue|grep -w "FIXA") ]] && nombrevalue+=[GERADOR]
 		 for arqx in `ls $SCPT_DIR`; do
  			[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
  			cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
 			echo "$arqx" >> ${DIR}/${KEY}/${LIST}
		 done

		if [[ $gen_gen = @(Y|y|S|s) ]]; then
			echo "generador autorizado para generar keys de generadores" > ${DIR}/${KEY}/autorizar &>/dev/null
			echo "autorizar" >> ${DIR}/${KEY}/${LIST}
		fi

		tipo="GEN"
		if [[ $attGEN = @(Y|y|S|s) ]]; then
			[[ -e ${DIR}/${KEY}/gerar.sh ]] && rm ${DIR}/${KEY}/gerar.sh
			[[ -e ${DIR}/${KEY}/http-server.py ]] && rm ${DIR}/${KEY}/http-server.py
			nombrevalue+="_ACT"
			tipo+="_ACTUALIZACION"
		fi
		nombrevalue+="_GEN"
		echo "$nombrevalue" > ${DIR}/${KEY}.name
		[[ -e /etc/gen_at.txt ]] && at now +$(cat /etc/gen_at.txt) <<< "rm -rf ${DIR}/${KEY}.name; rm -rf ${DIR}/${KEY}" &>/dev/null
		linck=2
		key_ok
elif [[ $1 = 2 ]]; then
		#ADM BASIC FIJA
		[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
		read -p "Nombre de usuario ( comprador de la key ): " nombrevalue
		[[ -z $nombrevalue ]] && nombrevalue="SIN NOMBRE"
 		arqslist="$BASICINST"
		 for arqx in `echo "${arqslist}"`; do
			[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
			cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
			echo "$arqx" >> ${DIR}/${KEY}/${LIST}
		 done
		 echo KEY_FIJA > ${DIR}/${KEY}/key.fija
		 echo "$nombrevalue" > ${DIR}/${KEY}.name
		 [[ -e /etc/gen_at.txt ]] && at now +$(cat /etc/gen_at.txt) <<< "rm -rf ${DIR}/${KEY}.name; rm -rf ${DIR}/${KEY}" &>/dev/null
		 tipo="FIJADA"
		 linck=1
		 key_ok
elif [[ $1 = 4 ]]; then
		unset time
		unset text
		unset num
		clear
		msg -bar
		echo -e "\033[7;49;35m      Configuracion de auto eliminacion de keys      \033[0m"
		msg -bar
		menu_func "MINUTOS" "HORAS" "DESACTIVAR $genat"
		msg -bar
		echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mAtras"
		msg -bar
		selection=$(selection_fun 3)
		case ${selection} in
			1)time=minutes && text=MINUTOS;;
			2)time=hours && text=HORAS;;
			3)[[ -e /etc/gen_at.txt ]] && rm /etc/gen_at.txt && registro auto_eliminar_fijado_en:OFF
			  return;;
			0)return;;
		esac
		echo -ne "ESCRIBA LA CATIDAD DE $text: " && read num	
		[[ ! -z $num ]] && echo $num $time > /etc/gen_at.txt && registro auto_eliminar_fijado_en:ACTIVO TIEMPO_DEFINIDO:$num$text
		gerar_key
fi
}

gerar_key () {
valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
unset KEY
KEY="$valuekey"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py lista-arq $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
[[ -e /etc/gen_at.txt ]] && genat="CADA: \033[1;32m$(cat /etc/gen_at.txt)" || genat="\033[1;31mOff"
clear
msg -bar
echo -e "\033[7;49;35m            Seleccione el tipo de Keys               \033[0m"
msg -bar

[[ -e /etc/SCRIPT/gerar.sh ]] && {

menu_func "GENERAR KEY DE INSTALACIÓN ChumoGH" "GENERAR KEY FIJA DE INSTALACIÓN VPS-MX" "GENERAR KEY DE GENERADOR DE KEYS" "AUTO ELIMINACION DE KEY $genat"
msg -bar
echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mAtras"
msg -bar
selection=$(selection_fun 4)
case ${selection} in
	1) gen_key_menu 1;;
	2) gen_key_menu 2;;
	3) gen_key_menu 3;;
	4) gen_key_menu 4;;
	0)return;;
esac
} || {
menu_func "GENERAR KEY DE INSTALACIÓN ChumoGH" "GENERAR KEY FIJA DE INSTALACIÓN VPS-MX" "AUTO ELIMINACION DE KEY $genat"
msg -bar
echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mAtras"
msg -bar
selection=$(selection_fun 3)
case ${selection} in
	1) gen_key_menu 1;;
	2) gen_key_menu 2;;
	3) gen_key_menu 4;;
	0)return;;
esac
 }
}

key_ok () {
keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
registro KEY_INSTALL_DE:$tipo KEY:$keyfinal NOMBRE:$nombrevalue
clear
msg -bar
echo -e "\033[7;49;35m       >>>>>Key Generada Con Exito!<<<<<             \033[0m"
echo -e "Key Activa $(printf '%(%D-%H:%M:%S)T')  \n\n 💥 $keyfinal  💥"
msg -bar
echo -e "Instalador Oficial"
msg -bar
echo -e "wget -q https://www.dropbox.com/s/i87udxpj1lj17sa/instala.sh; chmod +x instala.sh;./instala.sh \n"
msg -bar
echo -e " 🧬 Soporte : Ubuntu 14.04 - 16.04 - 20.04\n"
echo -e "Verificada, https://t.me/ChumoGH Reseller : $vkey\n"
echo -e ' 🪦 Solicita tus Creditos 🛡️⚔️'
msg -bar
#links_inst $linck
echo -ne "\033[1;37m Enter para Finalizar"
read foo
}

att_gen_key () {
i=0
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo "[$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
keys="$keys $arqs"
let i++
fi
done
keys=($keys)
msg -bar
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Seleccione qué Actualizar[t=todos]: " -e -i 0 value
done
[[ $value = 0 ]] && return
if [[ $value = @(t|T) ]]; then
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
KEYDIR="$DIR/$arqs"
rm $KEYDIR/*.x.c &> /dev/null
 if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then #Keyen Atualiza
 rm ${KEYDIR}/${LIST}
   for arqx in `ls $SCPT_DIR`; do
    cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
    echo "${arqx}" >> ${KEYDIR}/${LIST}
    rm ${SCPT_DIR}/*.x.c &> /dev/null
    rm $KEYDIR/*.x.c &> /dev/null
   done
 arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 fi
let i++
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
msg -bar
echo -ne "\033[0m" && read -p "Enter"
return 0
fi
KEYDIR="$DIR/${keys[$value]}"
[[ -d "$KEYDIR" ]] && {
rm $KEYDIR/*.x.c &> /dev/null
rm ${KEYDIR}/${LIST}
  for arqx in `ls $SCPT_DIR`; do
  cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
  echo "${arqx}" >> ${KEYDIR}/${LIST}
  rm ${SCPT_DIR}/*.x.c &> /dev/null
  rm $KEYDIR/*.x.c &> /dev/null
  done
 arqsx=$(ofus "$IP:8888/${keys[$value]}/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 read -p "Enter"
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 }
}

remover_key () {
unset i
unset keys
unset value
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
clear
msg -bar
echo -e "\033[7;49;35m                    Lista de Keys                    \033[0m"
msg -bar
keys="$keys retorno"
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
let i++

if [[ ! -e ${DIR}/${arqs}/used.date ]] && [[ ! -e ${DIR}/${arqs}/key.fija ]]; then
echo -e "$(msg -verd "[$i]") \033[0;49;93m$arqsx\n          \033[0;49;36m($(cat ${DIR}/${arqs}.name))\033[1;32m (ACTIVA)\033[0m"
msg -bar
elif [[ ! -e ${DIR}/${arqs}/key.fija ]]; then
echo -e "$(msg -verd "[$i]") \033[0;49;31m$arqsx\n    \033[0;49;36m($(cat ${DIR}/${arqs}.name))\033[5;49;31m (USADA): \033[0;49;93m$(cat ${DIR}/${arqs}/used.date) IP:$(cat ${DIR}/${arqs}/used)\033[0m"
msg -bar
else
echo -e "$(msg -verd "[$i]") \033[0;49;93m$arqsx\n          \033[0;49;36m($(cat ${DIR}/${arqs}.name)) \033[0;49;34m($(cat ${DIR}/${arqs}/key.fija))\033[0m"
msg -bar
fi

keys="$keys $arqs"
done
keys=($keys)
echo -e "$(msg -verd "[0]")$(msg -aqua ">") $(msg -bra "\033[7;49;35mAtras")"
msg -bar
value=$(selection_fun $i)
[[ -d "$DIR/${keys[$value]}" ]] && rm -rf $DIR/${keys[$value]}* && keydel=$(ofus "$IP:8888/${keys[$value]}/$LIST") && registro key_eliminada $keydel &&remover_key
}

remover_key_usada () {
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
 [[ $1 = delall ]] && rm -rf ${DIR}/*
 if [[ -e ${DIR}/${arqs}/used.date ]]; then #KEY USADA
 	if [[ ! -e ${DIR}/${arqs}/key.fija ]]; then
       rm -rf ${DIR}/${arqs}*
    fi
 fi
let i++
done
}

reg_key_used () {
	echo > $IVAR
	registro se_limpio_el_registro_de_keys_usadas
}

start_gen () {
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "http-server.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS generador /bin/http-server.sh -start
registro generador_online
clear
msg -bar
echo -e "\033[1;32m                Generador en linea"
msg -bar
echo -ne "\033[1;97m Poner en linea despues de un reinicio [s/n]: "
read start_ini
msg -bar
[[ $start_ini = @(s|S|y|Y) ]] && {
	crontab -l > /root/cron
	echo "@reboot screen -dmS generador /bin/http-server.sh -start" >> /root/cron
	crontab /root/cron
	rm /root/cron
}
else
killall http-server.sh
registro generador_offline
crontab -l > /root/cron
sed -i '/http-server.sh/ d' /root/cron
crontab /root/cron
rm /root/cron
clear
msg -bar
echo -e "\033[1;31m            Generador fuera de linea"
msg -bar
sleep 3
fi
}

message_gen () {
read -p "NUEVO MENSAJE: " MSGNEW
echo "$MSGNEW" > ${SCPT_DIR}/message.txt
msg -bar
registro cambio_creditos
}

rmv_iplib () {
echo -e "SERVIDORES DE KEY ACTIVOS!"
rm /var/www/html/newlib && touch /var/www/html/newlib
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
var=$(cat ${DIR}/${arqs}.name)
ip=$(cat ${DIR}/${arqs}/keyfixa)
echo -ne "\033[1;31m[USUARIO]: (\033[1;32m${var%%[*]}\033[1;31m) \033[1;33m[GERADOR]:\033[1;32m ($ip)\033[0m"
echo "$ip" >> /var/www/html/newlib && echo -e " \033[1;36m[ATUALIZADO]"
fi
done
echo "104.238.135.147" >> /var/www/html/newlib
msg -bar
read -p "Enter"
}

atualizar_geb () {
clear
msg -bar
echo -e " \033[1;37mACTUALIZADOR DE GENERADOR DE KEYS"
msg -bar
menu_func "USAR CONTRASEÑA DE ADMINISTRADOR" "USAR KEY DE ACTUALIZACION"
msg -bar && echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mREGRESAR"
msg -bar
selection=$(selection_fun 2)
case ${selection} in
1)pass_admin;;
2)key_update;;
esac
}

key_update () {
clear
msg -bar
echo -e "\033[1;37m ACTUALIZANDO......"
msg -bar
rm -rf $SCPT_DIR &>/dev/null
wget https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/BOT/instgerador.sh &> /dev/null; chmod 777 instgerador.sh* && ./instgerador.sh*
sleep 3
}

pass_admin () {
permited=$(ofus $(curl -sSL "https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/BOT/passw"))
read -p "ESCRIBA SU CONTRASEÑA: " passw
if [[ $permited = $passw ]]; then
	clear
	msg -bar
	echo -e "\033[1;37m ACTUALIZANDO......"
	msg -bar
	sleep 2
	wget -O $HOME/instger.sh https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/BOT/instgerador.sh &>/dev/null
	chmod +x $HOME/instger.sh
	cd $HOME
	rm -rf $SCPT_DIR &>/dev/null
	./instger.sh
	rm $HOME/instger.sh &>/dev/null
	registro actualizo_generador
else
	clear
	msg -bar
	echo -e "\033[1;37m LA CONTRASEÑA NO COINCIDE"
	echo -e "\033[1;37m ACTUALIZACION CANSELADA!"
	msg -bar
	sleep 3
fi
}

links_inst  () {
if [[ $1 = 1 ]]; then
[[ $2 = 1 ]] && clear
msg -bar
echo -e "\033[7;49;35m             LINKS INSTALL SCRIPT ChumoGH             "
msg -bar
echo -e "\033[1;37mwget -q https://www.dropbox.com/s/i87udxpj1lj17sa/instala.sh; chmod +x instala.sh;./instala.sh"
msg -bar
[[ $2 = 1 ]] && echo -ne "\033[1;37m Enter para Finalizar"
[[ $2 = 1 ]] && read foo
elif [[ $1 = 2 ]]; then
msg -bar
echo -e "\033[7;49;35m             LINKS INSTALL SCRIPT ChumoGH         "
msg -bar
echo -e "\033[1;37msudo apt update -y; apt upgrade -y; https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/BOT/instgerador.sh &> /dev/null; chmod 777 instgerador.sh* && ./instgerador.sh*"
msg -bar
fi
}

bot_menu () {
CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
[[ ! -e "${CIDdir}/confbot.sh" ]] && wget -O ${CIDdir}/confbot.sh https://raw.githubusercontent.com/ChumoGH/VPSbot/main/confbot.sh &> /dev/null && chmod +x ${CIDdir}/confbot.sh
sed -i -e 's/\r$//' ${CIDdir}/confbot.sh
source ${CIDdir}/confbot.sh
bot_conf
}

key_used () {
echo -e " \033[1;37mKEYS USADAS: \033[1;49;95m[\033[1;32m$(cat $IVAR)\033[1;49;95m]"
msg -bar
}

# SISTEMA DE SELECAO
selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m$(fun_trans "Selecione una Opcion"): " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

fun_trans () { 
local texto
local retorno
declare -A texto
#SCPidioma="${SCPT_DIR}/idioma"
#[[ ! -e ${SCPidioma} ]] && touch ${SCPidioma}
#local LINGUAGE=$(cat ${SCPidioma})
[[ -z $LINGUAGE ]] && LINGUAGE=es
[[ $LINGUAGE = "es" ]] && echo "$@" && return
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://raw.githubusercontent.com/rudi9999/Herramientas/main/trans &> /dev/null
[[ ! -e /etc/texto-adm ]] && touch /etc/texto-adm
source /etc/texto-adm
if [[ -z "$(echo ${texto[$@]})" ]]; then
#ENGINES=(aspell google deepl bing spell hunspell apertium yandex)
#NUM="$(($RANDOM%${#ENGINES[@]}))"
retorno="$(source trans -e bing -b es:${LINGUAGE} "$@"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
echo "texto[$@]='$retorno'"  >> /etc/texto-adm
echo "$retorno"
else
echo "${texto[$@]}"
fi
}

menu_func () {
local options=${#@}
local array
for((num=1; num<=$options; num++)); do
echo -ne "$(msg -verd "[$num]") $(msg -aqua ">") "
  array=(${!num})
  case ${array[0]} in
    "-vd")msg -verd "\033[1;33m[!]\033[1;32m $(fun_trans "${array[@]:1}")" | sed ':a;N;$!ba;s/\n/ /g';;
    "-vm")msg -verm2 "\033[1;33m[!]\033[1;31m $(fun_trans "${array[@]:1}")" | sed ':a;N;$!ba;s/\n/ /g';;
    "-fi")msg -azu "$(fun_trans "${array[@]:2}") ${array[1]}" | sed ':a;N;$!ba;s/\n/ /g';;
    *)msg -azu "$(fun_trans "${array[@]}")" | sed ':a;N;$!ba;s/\n/ /g';;
  esac
done
}

registro () {
	log="/etc/gerar-sh-log"
	#echo "$(date |cut -d' ' -f3,4)" >> $log
	#echo "-----------------------------------------------------" >> $log
	if [[ $1 = 1 ]]; then
		clear
		msg -bar
		echo -e "\033[7;49;35m           =====>>►►  REGISTRO  ◄◄<<=====            \033[0m"
		msg -bar
		echo -ne "\033[1;36m" && cat /etc/gerar-sh-log 2>/dev/null || echo "NINGUN REGISTRO EN ESTE MOMENTO" && echo -ne "enter para salir o x para limpiar registro: " && read var 
		[[ $var = x ]] && rm /etc/gerar-sh-log &>/dev/null
	else
		milog=($@)
		var=$#
		echo "$_fecha $_hora" >> $log
			for (( i = 0; i < $var; i++ )); do
				echo "${milog[$i]}" >> $log
			done
		echo "-----------------------------------------------------" >> $log
	fi
}

meu_ip

unistall () {
clear
echo -e "\033[1;31m ESTO QUITARA POR COMPLETO EL GENERADOR DE KEYS"
read -p " ESTA SEGURO DE ESTO? [S/N]: " -e -i n unistal
if [[ $unistal = @(Y|y|S|s) ]]; then
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
[[ ! -z $PID_GEN ]] && start_gen
rm -rf /etc/MEUIPADM &>/dev/null
rm -rf /etc/gen_at.txt &>/dev/null
rm -rf /etc/texto-adm &>/dev/null
rm -rf /etc/newadm-instalacao &>/dev/null
rm -rf /usr/bin/trans &>/dev/null
rm -rf /bin/http-server.sh &>/dev/null
rm -rf $DIR &>/dev/null
rm -rf $SCPT_DIR &>/dev/null
rm -rf /etc/gerar-sh-log &>/dev/null
rm -rf /usr/bin/gerar &>/dev/null
rm -rf /usr/bin/gerar.sh &>/dev/null
fi
}

info_sys () {
info_so=$(printf '%-18s' "$(os_system)")
info_ip=$(printf '%-19s' "$(meu_ipe)")
info_ram1=$(printf '%-7s' "${ram1}")
info_ram3=$(printf '%-6s' "${ram3}")
info_fecha=$(printf '%-16s' "${_fecha}")
info_hora=$(printf '%-16s' "${_hora}")

msg -bar
echo -e "\033[7;49;35m      =====>>►► 🐲 GEN ChumoGH•VPS 🐲 ◄◄<<=====       \033[0m"
msg -bar
echo -e " \033[1;32mSISTEMA                 MEMORIA         PROSESADOR"
echo -e " \033[1;49;96mS.O: \033[1;37m$info_so \033[1;49;96mRAM:    \033[1;32m$info_ram1 \033[1;49;96mCPU: \033[1;32m$_core"
echo -e " \033[1;49;96mIP: \033[1;37m$info_ip \033[1;49;96mUSADA:  \033[1;32m$info_ram3  \033[1;49;96mEN USO: \033[1;32m$_usop"
echo -e " \033[1;49;96mFECHA: \033[1;37m$info_fecha \033[1;49;96mLIBRE:  \033[1;32m$ram2"
echo -e " \033[1;49;96mHORA:  \033[1;37m$info_hora \033[1;49;96mEN USO: \033[1;32m$_usor"

[[ -e ${SCPT_DIR}/message.txt ]] && msg -bar && msg -bra " \033[1;37mKEY GENERADOR BY \033[1;32m➣➣ \033[1;96m $(cat ${SCPT_DIR}/message.txt) "
msg -bar
}

#########VISUALIZACION DE MENU

clear
info_sys
key_used
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31moff" || PID_GEN="\033[1;32monline"
echo -e "\033[1;37mDirectorio de archivos sincronizados \033[1;31m${SCPT_DIR}\033[0m"
msg -bar
menu_func "GENERADOR DE KEYS" "ELIMINAR/MIRAR KEYS" "LIMPIAR REGISTRO DE KEYS USADAS" "ALTERAR ARCHIVOS DE KEY BASICA" "ENCENDER/APAGAR GENERADOR $PID_GEN\033[0m" "VER LINKS DE INSTALACION" "CONFIGURAR BOT DE TELEGRAM" "CAMBIAR CREDITOS" "VER REGISTRO" "-vd ACTUALIZAR GENERADOR" "-vm DESINSTALAR GENERADOR"
msg -bar && echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mSALIR DEL SCRIPT"
msg -bar
selection=$(selection_fun 11)
case ${selection} in
1)gerar_key;;
2)remover_key;;
3)reg_key_used;;
4)mudar_instacao;;
5)start_gen;;
6)links_inst 1 1;;
7)bot_menu;;
8)message_gen;;
9)registro 1;;
10)atualizar_geb;;
11)unistall;;
0)cd $HOME && exit 0;;
esac
/usr/bin/gerar.sh
