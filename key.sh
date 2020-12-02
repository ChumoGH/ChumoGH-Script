
SCPdir="/etc/cgh" && [[ ! -d ${SCPdir} ]] && mkdir  ${SCPdir}
cd /etc/cgh
rm -f manager*
#wget -q https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/manager
#cat manager> /bin/gerar
echo 'source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/manager)' > /bin/gerar
chmod +x /bin/gerar
rm -f key.*
