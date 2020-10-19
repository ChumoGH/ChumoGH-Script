
mkdir /etc/cgh
cd /etc/cgh
wget -q https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/manager
echo "cd /etc/cgh && bash ./manager" > /bin/gerar
chmod +x /bin/gerar
