#!/bin/bash
curl -q https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg > /tmp/ssrrmu.sh
curl https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/SCRIPT/C-SSR.sh >> /tmp/ssrrmu.sh
sed -i "s;VPS•MX;ChumoGH-ADM;g" /tmp/ssrrmu.sh
sed -i "s;@Kalix1;ChumoGH;g" /tmp/ssrrmu.sh
sed -i "s;VPS-MX;chumogh;g" /tmp/ssrrmu.sh
chmod +x /tmp/ssrrmu.sh && bash /tmp/ssrrmu.sh
#sed '/gnula.sh/ d' /tmp/ssrrmu.sh > /bin/ejecutar/crontab
