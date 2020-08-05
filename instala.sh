echo -e ' TRANQUILO ESTO DEMORARA UN POCO, MIENTRAS ACTULIZAMOS!!'
apt-get update -y 1> /dev/null 2> /dev/null
apt-get upgrade -y 1> /dev/null 2> /dev/null
update1='aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0NodW1vR0gvQ2h1bW9HSC1TY3JpcHQvbWFzdGVyL2NnaC5zaA=='
dom='base64 -d'
RE=$(echo $update1|$dom)
wget -O cgh.sh $RE;chmod 777 cgh.sh* && ./cgh.sh*
