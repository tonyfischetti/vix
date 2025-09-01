# bash, subshells, stderr redirection, curl

# () <- subshell

MYIP=$(curl ifconfig.m 2> /dev/null)
echo "My (external) IP is ${MYIP:-unknown}"
# or MYIP=$(curl -s ifconfig.me)
# or MYIP=$(curl -fsS ifconfig.me) to show errors

# the following is an older (worse) way
# MYIP=`curl ifconfig.me 2> /dev/null`
# echo "My (external) IP is ${MYIP:-unknown}"
