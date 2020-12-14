#!/bin/bash
echo "FUNCION EN TESTUS "
auto_add_user () {
#$1 = usuário
#$2 = senha
#$3 = limite
#$4 = data
if [ "$1" = "" ]; then
echo -e "${cor[4]} ${txt[114}"
var_exit="1"
fi
if [ "$2" = "" ]; then
echo -e "${cor[4]} ${txt[114}"
var_exit="1"
fi
if [ "$3" = "" ]; then
echo -e "${cor[4]} ${txt[114}"
var_exit="1"
fi
if [ "$4" = "" ]; then
echo -e "${cor[4]} ${txt[114}"
var_exit="1"
fi
if [ "$var_exit" = "1" ]; then
sleep 0.5s
unset var_exit
 else
if [ "$OPENVPN" = "on" ]; then
open_1 $1 $2 30 $3 s
return
fi
useradd -M -s /bin/false $1 -e $4
(echo $2; echo $2) | passwd $1 2>/dev/null
echo -e "${cor[5]} $1 Criado Com Sucesso!"
echo -e "Usuario: $1"
echo -e "Senha: $2"
echo -e "Loguins: $3"
echo -e "Data: $4"
 if [ -e $dir_user/$1 ]; then
rm $dir_user/$1
 fi
touch $dir_user/$1
echo "senha: $senha" >> $dir_user/$1
echo "limite: $limite" >> $dir_user/$1
echo "data: $data" >> $dir_user/$1
fi
}

function_1 () {
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
echo -e "${cor[4]} ${txt[99]}"
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
for user in `awk -F : '$3 > 900 { print $1 }' /etc/passwd | grep -v "nobody" |grep -vi polkitd |grep -vi systemd-[a-z] |grep -vi systemd-[0-9]`; do
echo -e "${cor[5]} ${txt[100]}"
echo -e "\033[1;31m $user"
if [ -e $dir_user/$user ]; then
pass=$(cat $dir_user/$user | grep "senha" | awk '{print $2}')
data=$(cat $dir_user/$user | grep "data" | awk '{print $2}')
limit=$(cat $dir_user/$user | grep "limite" | awk '{print $2}')
 if [ "$pass" = "" ]; then
pass="ultimate"
 fi
 if [ "$data" = "" ]; then
data=$(date '+%C%y-%m-%d' -d "+30 days")
 fi
 if [ "$limit" = "" ]; then
limit="30"
 fi
 if [ ! -e "$HOME/adm-backup" ]; then
echo "$user $pass $limit $data" > /root/adm-backup
echo -e "${cor[4]} $user\n $pass\n $limit\n $data"
 else
echo "$user $pass $limit $data" >> /root/adm-backup
echo -e "${cor[4]} $user\n $pass\n $limit\n $data"
 fi
else
echo -e "${cor[5]} ${txt[101]}"
echo -e "${cor[5]} ${txt[102]}"
read -p " ©$user ${txt[103]} " pass
read -p " ©$user ${txt[104]} " datas2
number_var $datas2
if [ "$var_number" = "" ]; then
 if [ -e $HOME/adm-backup ]; then
rm $HOME/adm-backup
 fi
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
return
 else
datas="$var_number"
fi
data=$(date '+%C%y-%m-%d' -d "+$datas days")
read -p " ©$user ${txt[105]} " limit2
number_var $limit2
if [ "$var_number" = "" ]; then
 if [ -e $HOME/adm-backup ]; then
rm $HOME/adm-backup
 fi
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
return
 else
limit="$var_number"
fi
 if [ ! -e "$HOME/adm-backup" ]; then
echo "$user $pass $limit $data" > /root/adm-backup
echo -e "${cor[4]} $user\n $pass\n $limit\n $data"
 else
echo "$user $pass $limit $data" >> /root/adm-backup
echo -e "${cor[4]} $user\n $pass\n $limit\n $data"
 fi
fi
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
done
echo "admpro" >> $HOME/adm-backup
echo -e "${cor[5]} ${txt[106]}"
echo -e "${cor[5]} ${txt[107]} \033[1;36m$HOME/adm-backup! ${cor[0]}"
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
}

function_2 () {
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
echo -e "${cor[4]} ${txt[108]}
 ${txt[109]}"
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
read -p " [${txt[110]}]: " arq
 if [ ! -e "$arq" ]; then
cd $HOME
wget -O backup-adm $arq -o /dev/null
  if [ ! -e "$HOME/backup-adm" ]; then
echo -e "${cor[5]} ${txt[111]}"
return
  fi
test=$(cat $HOME/backup-adm | egrep -o "admpro")
  if [ "$test" = "" ]; then
echo -e "${cor[5]} ${txt[112]}"
return
  fi
arq_bkp="$HOME/backup-adm"
    else
test=$(cat $arq | egrep -o "admpro")
  if [ "$test" = "" ]; then
echo -e "${cor[5]} ${txt[112]}"
return
  else
arq_bkp="$arq"
  fi
 fi
echo -e "\033[1;37m ${txt[113]}"
cd /etc/adm-lite
while read backup_adm; do
usuario=$(echo "$backup_adm" | awk '{print $1}')
senha=$(echo "$backup_adm" | awk '{print $2}')
limite=$(echo "$backup_adm" | awk '{print $3}')
data=$(echo "$backup_adm" | awk '{print $4}')
fim=$(echo "$backup_adm" | egrep -o "admpro")
if [ "$fim" != "" ]; then
break
fi
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
auto_add_user "$usuario" "$senha" "$limite" "$data"
done < $arq_bkp
echo -e "${cor[1]} ══════════════════════════════════= ${cor[0]}"
cd /etc/adm-lite
}
#CUCARACHA
