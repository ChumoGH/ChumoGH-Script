id1=$(free -h | grep -i mem | awk {'print $4'})
idM=$(echo $id1 |sed 's/[A-Z]//g')
idm=$(echo $idM |sed 's/[a-z]//g')
n=90
tiempo=$(printf '%(%D-%H:%M:%S)T') 
if [ "$n" -gt "$idm" ]; then 
echo $idm "Limpiando y Reiniciado por sobreConsumo el " $tiempo
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/gnula.sh)
else 
echo $n " Esta bajo el limite en " $tiempo 
fi
