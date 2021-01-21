function swap(){
#echo -e "Se instalara la particion SWAP en tu vps"
echo -e "Escribe la cantidad de GB, Similar o Superior a su Memoria RAM"
echo -e "     No puede exceder el tamaño del disco duro de tu vps"
echo -e "Ejemplo : 4G"
gbswap=2
echo -e "Cuantos GB quieres agregar a memoria SWAP"
read -p ": " gbswap
set -e
fallocate -l $gbswap /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile   none    swap    sw    0   0" | sudo tee -a /etc/fstab
echo -e "Proceso finalizado [complete]"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
exit
}
swap
