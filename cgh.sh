#!/bin/bash

killall apt apt-get &> /dev/null
dom='base64 -d'
cd $HOME
rm -f instala.* > /dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || apt-get install gawk -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] || apt-get install mlocate -y &>/dev/null
rm $(pwd)/$0 &> /dev/null
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -bar2)cor="${AZUL}${NEGRITO}======================================================" && echo -e "${cor}${SEMCOR}";;
  -bar)cor="${AZUL}${NEGRITO}========================================" && echo -e "${cor}${SEMCOR}";;
 esac
}
fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
fecha=`date +"%d-%m-%y"`;
dom='base64 -d'
SCPdir="/etc/adm-lite"
SCPinstal="$HOME/install"
SCPidioma="${SCPdir}"
SCPusr="${SCPdir}"
SCPfrm="${SCPdir}"
SCPinst="${SCPdir}"
## root check
if ! [ $(id -u) = 0 ]; then
clear
		echo ""
		echo "vvvvvvvvvvvvvvvvvvvv"
		echo "    Erro Fatal!!"
		echo "^^^^^^^^^^^^^^^^^^^^"
		echo "Este script debe ejecutarse como root!"

		printTitle "How to fix it?"
		echo "Ejecute el script así:"
		echo "sudo -i"

		echo "Finalizando . . ."
		echo $(date)
		msg -bar2
		exit
fi
update_pak () {
dpkg --configure -a
unset Key > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mExito!" || echo -e "\033[1;31m- \033[1;31mFallo"
apt-get install software-properties-common -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
apt-add-repository universe -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Install SysBanner"
apt install sysvbanner -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Install Lolcat   "
apt install lolcat -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Install Figlet   "
apt install figlet -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Install Cowsay   "
apt install cowsay -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
sleep 2s
return
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
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

fun_bar 'update_pak'
echo -e " LOLCAT - FIGLET - COWSAY - TOILET INSTALADOS CORRECTAMENTE "| lolcat
function_verify () {
  echo "verify" > $(echo -e $(echo 2f62696e2f766572696679737973|sed 's/../\\x&/g;s/$/ /'))
}

instalar_fun () {
cd /etc/adm-lite && bash cabecalho --instalar
}


install_fim () {
if cat /root/.bashrc | grep ChumoGH; then
echo "clear" >> /root/.bashrc
echo 'DATE=$(date +"%d-%m-%y")' >> /root/.bashrc
echo 'TIME=$(date +"%T")' >> /root/.bashrc
echo 'figlet -k ChumoGH | lolcat' >> /root/.bashrc
echo 'echo -e ""' >> /root/.bashrc
echo 'echo -e " Fecha de Instlacion : " $(cat < /bin/ejecutar/fecha)' >> /root/.bashrc
echo 'echo -e " Nombre del Servidor : $HOSTNAME"' >> /root/.bashrc
echo 'echo -e " Tiempo en Linea : $(uptime -p)"' >> /root/.bashrc
echo 'echo -e " Fecha del Servidor : $DATE"' >> /root/.bashrc
echo 'echo -e " Hora del Servidor : $TIME"' >> /root/.bashrc
echo 'echo -e ""' >> /root/.bashrc
echo 'echo -e " Bienvenido!"' >> .bashrc
echo 'echo -e " Teclee cgh o menu para ver el listado de comandos."' >> /root/.bashrc
echo 'echo -e ""' >> /root/.bashrc
echo " $(source trans -b pt:${id} "STARTUP AGREGADO EXITOSAMENTE")"
else
wget -o /dev/null -O- https://raw.githubusercontent.com/ChumoGH/chumogh-gmail.com/master/toolmaster > /bin/toolmaster
chmod +x /bin/toolmaster
echo "clear" >> .bashrc
echo 'DATE=$(date +"%d-%m-%y")' >> /root/.bashrc
echo 'TIME=$(date +"%T")' >> /root/.bashrc
echo 'figlet -k ChumoGH | lolcat' >> /root/.bashrc
echo 'echo -e ""' >> /root/.bashrc
echo 'echo -e " Fecha de Instlacion : " $(cat < /bin/ejecutar/fecha)' >> /root/.bashrc
echo 'echo -e " Nombre del Servidor : $HOSTNAME"' >> /root/.bashrc
echo 'echo -e " Tiempo en Linea : $(uptime -p)"' >> /root/.bashrc
echo 'echo -e " Fecha del Servidor : $DATE"' >> /root/.bashrc
echo 'echo -e " Hora del Servidor : $TIME"' >> /root/.bashrc
echo 'echo -e ""' >> /root/.bashrc
echo 'echo -e "Bienvenido!"' >> .bashrc
echo 'echo -e " Teclee cgh o menu para ver el listado de comandos."' >> /root/.bashrc
echo 'echo -e ""' >> /root/.bashrc
echo " $(source trans -b pt:${id} "STARTUP AGREGADO EXITOSAMENTE")"
sleep 2
fi
[[ -e $HOME/lista ]] && rm $HOME/lista
clear
echo -e "${cor[5]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[5]}  $(source trans -b pt:${id} " Agregaremos un nombre de tu servidor.... OPCIONAL")"
echo -e "${cor[3]} $(source trans -b pt:${id} "Maximo 10 Caracteres. Para no distorcionar el DISEÑO/INTERFAZ")"
echo -e "${cor[5]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -ne " Nombre del Servidor : "; read name
echo $name > /etc/adm-lite/name
chmod +x /etc/adm-lite/name
echo $name > /root/name
fun_bar 
figlet $name
opti=0
rm -rf /bin/ejecutar 2>/dev/null 
mkdir /bin/ejecutar
echo $opti > /bin/ejecutar/val
echo $opti > /bin/ejecutar/uskill
echo "desactivado" > /bin/ejecutar/val1
echo "Verified 【 匚 卄 ㄩ 爪 ㄖ Ꮆ 卄 】 ADM 2021" > /etc/adm-lite/exito
chmod +x /etc/adm-lite/exito
echo -e "${cor[5]} $(source trans -b pt:${id} "NOMBRE AGREGADO EXITOSAMENTE")"
echo -ne " \033[0m"
clear
echo -e "${cor[5]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "\033[1;32mCAMBIAR ZONA HORARIA EN ( * \033[1;33m menu\033[1;32m *\033[1;33m opcion 7 \033[1;32m*\033[1;33m opcion 14 \033[1;32m)"
echo -e "${cor[5]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[3]} ChumoGH-Pannel Instalada Correctamente!"
echo -e "${cor[2]}    ACTUALIZACION TEMPORAL CONCEDIDA EXITOSAMENTE"
echo -e "${cor[3]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[3]} |∆| ${cor[2]} Ahora puedes acceder al PANNEL"
echo -e "${cor[3]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[2]} $(source trans -b pt:${id} "Use los Comandos"): cgh, menu, adm"
echo $fecha > /bin/ejecutar/fecha
echo $Key > /bin/ejecutar/key.fix
echo -e " Fecha de Instalacion : " $(cat < /bin/ejecutar/fecha)
echo -e "${cor[2]} Para acceder al MENU, DISFRUTA LA ESTANCIA!"
echo -e "${cor[2]} Reinicie para completar Instalacion - OPCIONAL - "
echo -e "${cor[2]} RECOMENDABLE ACCEDER COMO ROOT y/o ADMINISTRADOR"
echo ""
figlet $name | lolcat
exit
}
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
verificar_arq () {
echo $1 > $HOME/log.txt
#cd ${SCPinstal}
}
fun_ip

valid_fun () {
[[ -d /etc/adm-lite ]] && rm -rf /etc/adm-lite
mkdir /etc/adm-lite
cd /etc/adm-lite
echo "cd /etc/adm-lite && bash ./menu" > /bin/menu
echo "cd /etc/adm-lite && bash ./menu" > /bin/cgh
echo "cd /etc/adm-lite && bash ./menu" > /bin/adm
chmod +x /bin/menu
chmod +x /bin/cgh
chmod +x /bin/adm
cd /etc/adm-lite
touch /etc/adm-lite/index.html
mv -f ${SCPinstal}/* /etc/adm-lite/
cd $HOME
echo -e "${cor[3]} $(source trans -b pt:${id} "AGREGANDO PAQUETES, y SERVICIOS NECESARIOS")"
echo -e "${cor[1]}####################################################"
chmod +x /etc/adm-lite/*
instalar_fun
function_verify
sleep 1s 
}
invalid_key () {
echo -e ' '
msg -bar2 && msg -verm "Key Failed! " && msg -bar2
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
cd $HOME
[[ -d $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -d /etc/adm-lite ]] && rm -rf /etc/adm-lite
[[ -d $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -e /bin/menu ]] && rm /bin/menu
[[ -e $HOME/chumogh ]] && rm -rf $HOME/chumogh
rm -f instala.*  > /dev/null
rm -f /bin/cgh > /dev/null
rm -rf /bin/ejecutar > /dev/null
unset key > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mExito!" || echo -e "\033[1;31m- \033[1;31mFallo" > error.log
cowsay  "☆ChumoGH☆ ADM SCRIPT Te agradece por preferirnos, pero desafortunadamente tu Key es INVALIDA" >> error.log
echo "Key Invalida, Contacta con el Desarrolador" >> error.log
echo "  ● Compra Keys al +593987072611 " >> error.log
echo -e ' t.me/ChumoGH  - @ChumoGH' >> error.log
cat error.log | lolcat
exit
}

while [[ ! $Key ]]; do
clear
cowsay -f stegosaurus "BIENVENIDO Y GRACIAS POR UTILIZAR - - - - - - - -【 ★ ChumoGH ★ 】 ADM 2021 "| lolcat
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games;
echo -e "\033[1;32m ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆ "
msg -ne "Key de Instalacion: " && read Key
tput cuu1 && tput dl1
done
msg -ne "Key: "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[1;32m Verificando" || {
   invalid_key
   }
echo -e "\033[1;32m Verified"
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
sleep 2s
updatedb
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
cor[1]="\033[1;36m"
cor[2]="\033[1;33m"
cor[3]="\033[1;31m"
cor[5]="\033[1;32m"
cor[4]="\033[0m"
cd $HOME
clear
locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
apt-get install gawk -y > /dev/null 2>&1
wget -O trans https://raw.githubusercontent.com/ChumoGH/chumogh-gmail.com/master/trans -o /dev/null 2>&1
mv -f ./trans /bin/ && chmod 777 /bin/*
cowsay -f ghostbusters "    ESCOJE TU IDIOMA DE PRERENCIA"| lolcat
echo -e "${cor[1]}==================================" | lolcat
echo -e "${cor[2]}       (Default : Español)\n${cor[1]}==================================\n${cor[2]}   [1]-BRASILEÑO : [2]-INGLES\n   [3]-ESPAÑOL   : [4]-FRANCES\n   [5]-ITALIANO  : [6]-CHINO"
echo -e "${cor[1]}==================================" | lolcat
echo -ne " ESCOJE: "; read lang
case $lang in
1)
id="pt"
;;
2)
id="en"
;;
3)
id="es"
;;
4)
id="fr"
;;
5)
id="it"
;;
5)
id="ch"
;;
*)
id="es"
;;
esac
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e ""
echo -e "${cor[2]}\n\033[1;37m  Script Patrocinado por: @ChumoGH - Henry Chumo"
echo -e ""
echo -e "${cor[1]}=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠=≠"
echo -e "${cor[5]} INSTALADOR ChumoGH-SCRIPTS ®"
echo -e "${cor[1]}⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝ "
echo -e "${cor[3]} Iniciando Instalacion del ADM..."
echo -e "${cor[3]} Script V 4.2 Sujeto a Mejoras del MOD"
echo -e "${cor[1]} MEJORANDO PAQUETES DE DETECCIONES Y MULTILOGIN "
echo -e "${cor[1]}⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝⚝ "
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   src='aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0NodW1vR0gvY2h1bW9naC1nbWFpbC5jb20vbWFzdGVyL2xpc3Rh'
   for arqx in $(cat $HOME/lista-arq); do
   wget -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}"  
   done
   fun_bar 
	  echo -ne "${cor[4]}"
	  RE=$(echo $src|$dom)
	  wget -O $HOME/lista $RE -o /dev/null
	  valid_fun
   msg -bar2
   cd $HOME
   [[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq  
   [[ -e $HOME/lista ]] && rm $HOME/lista   
   [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal} 
   echo " Verified【 匚卄ㄩ爪ㄖᎶ卄 】 ADM 2021" > $HOME/exito
   install_fim
   else
invalid_key
fi
