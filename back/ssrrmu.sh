#!/bin/bash
echo ""
curl  https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg > /tmp/ssrrmu.sh
curl  https://www.dropbox.com/s/re3lbbkxro23h4g/C-SSR.sh >> /tmp/ssrrmu.sh
sed -i "s;VPS•MX;ChumoGH-ADM;g" /tmp/ssrrmu.sh
sed -i "s;@Kalix1;ChumoGH;g" /tmp/ssrrmu.sh
sed -i "s;VPS-MX;chumogh;g" /tmp/ssrrmu.sh
chmod +x /tmp/ssrrmu.sh && bash /tmp/ssrrmu.sh
#sed '/gnula.sh/ d' /tmp/ssrrmu.sh > /bin/ejecutar/crontab
