#!/bin/bash
fun_bar 'apt install cmake -y'
wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badvpn/badvpn-1.999.128.tar.bz2
tar xf badvpn-1.999.128.tar.bz2
#cd badvpn-1.999.128/
cd /etc/adm-lite/badvpn-1.999.128/
cmake /etc/adm-lite/badvpn-1.999.128 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
#cmake ~/badvpn-1.999.128 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
badvpn-udpgw --listen-addr 127.0.0.1:7200 > /dev/nul &
#echo 'badvpn-udpgw --listen-addr 127.0.0.1:7200 > /dev/nul &' >> /etc/rc.local
rm -rf badvpn-1.*

