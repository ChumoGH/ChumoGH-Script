#!/bin/bash
echo ""
curl  https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg > /tmp/bot.sh
curl  https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/Parches-TEM/ADMbot.sh >> /tmp/bot.sh
sed -i "s;VPS•MX;ChumoGH-ADM;g" /tmp/bot.sh
sed -i "s;@Kalix1;ChumoGH;g" /tmp/bot.sh
sed -i "s;VPS-MX;chumogh;g" /tmp/bot.sh
chmod +x /tmp/bot.sh && bash /tmp/bot.sh
