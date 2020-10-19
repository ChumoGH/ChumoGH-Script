
SCPdir="/etc/cgh" && [[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
cd /etc/cgh
wget -q https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/manager
cat << EOF > /bin/gerar
#!/bin/bash
cd ${SCPdir} && ./manager
EOF
chmod +x /bin/gerar
