#!/bin/bash
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;35m" [3]="\033[1;32m" [4]="\033[1;31m" [5]="\033[1;33m" [6]="\E[44;1;37m" [7]="\E[41;1;37m" )
barra="\033[0m\e[31m======================================================\033[1;37m"

fun_bar () {
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
tput cuu1 && tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
act_hora () {
echo "America/Chihuahua"
echo "America/Chihuahua" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Chihuahua /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
menu
}
act_hora1 () {
echo "America/Mexico_City"
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
menu
}
act_hora2 () {
echo "America/Hermosillo"
echo "America/Hermosillo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Hermosillo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
menu
}
act_hora3 () {
echo "America/Santiago"
timedatectl > /dev/null 2>&1
timedatectl list-timezones > /dev/null 2>&1
timedatectl list-timezones  | grep Santiago > /dev/null 2>&1
timedatectl set-timezone America/Santiago > /dev/null 2>&1
echo -e "$barra"
menu
}
act_hora4 () {
echo "America/Los_Angeles"
timedatectl > /dev/null 2>&1
timedatectl list-timezones > /dev/null 2>&1
timedatectl list-timezones  | grep Los_Angeles > /dev/null 2>&1
timedatectl set-timezone America/Los_Angeles > /dev/null 2>&1
echo -e "$barra"
menu
}
act_hora5 () {
echo "America/New_York"
echo "America/New_York" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
menu
}
act_hora6 () {
echo "America/Guatemala"
echo "America/Guatemala" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Guatemala /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
menu
}
act_hora7 () {
echo "America/Bogota"
echo "America/Bogota" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Bogota /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
menu
}
act_hora8 () {
echo "America/Guayaquil"
echo "America/Guayaquil" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Guayaquil /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e "$barra"
menu
}

verzm () {
timedatectl
echo -e "\033[1;31m PRESIONE ENTER PARA CONTINUAR \033[0m"
read -p " "
menu
}
shadowe_fun () {
#source /etc/adm-lite/cabelcaho
echo -e " \033[1;36m ZONA HORARIO \033[1;32m[ChumoGH-ADM]"
echo -e "$barra"
while true; do
echo -e "${cor[4]} [1] > ${cor[5]}ACTUALIZAR HORARIO  CHICHUAHUA"
echo -e "${cor[4]} [2] > ${cor[5]}ACTUALIZAR HORARIO  MEXICO"
echo -e "${cor[4]} [3] > ${cor[5]}ACTUALIZAR HORARIO  HERMOSILLO"
echo -e "${cor[4]} [4] > ${cor[5]}ACTUALIZAR HORARIO  AMERICA/SANTIAGO"
echo -e "${cor[4]} [5] > ${cor[5]}ACTUALIZAR HORARIO  America/Los_Angeles"
echo -e "${cor[4]} [6] > ${cor[5]}ACTUALIZAR HORARIO  America/New_York"
echo -e "${cor[4]} [7] > ${cor[5]}ACTUALIZAR HORARIO  America/Guatemala"
echo -e "${cor[4]} [8] > ${cor[5]}ACTUALIZAR HORARIO  America/Bogota"
echo -e "${cor[4]} [9] > ${cor[5]}ACTUALIZAR HORARIO  ECUADOR "
echo -e "${cor[4]} [10] > ${cor[5]}VER ZONA HORARIA ACTUAL "
echo -e "${cor[4]} [0] > ${cor[0]}SALIR\n${barra}"
while [[ ${opx} != @(0|[1-10]) ]]; do
echo -ne "${cor[0]}Digite una Opcion (1 a 1O) : \033[1;37m" && read opx
tput cuu1 && tput dl1
done
case $opx in
	0)
	exit;;
	1)
	fun_bar
	act_hora
	break;;
	2)
	fun_bar
	act_hora1
	break;;
	3)
	fun_bar
	act_hora2
	break;;
   	 4)
	 fun_bar
	act_hora3
	break;;
	 5)
	 fun_bar
	act_hora4
	break;;
	 6)
	 fun_bar
	act_hora5
	break;;
	 7)
	 fun_bar
	act_hora6
	break;;
	 8)
	 fun_bar
	act_hora7
	break;;
	 9)
	 fun_bar
	act_hora8
	break;;
	10)
	verzm
  	break;;
esac
done
}
shadowe_fun
