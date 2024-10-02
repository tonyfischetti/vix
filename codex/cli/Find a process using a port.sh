# lsof, find process using a port, port

lsof -i:PORTNUMBER
# COMMAND   PID USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
# node    71092 tony   19u  IPv6 0x0000000000000000      0t0  TCP *:hbci (LISTEN)

lsof -t -i:PORTNUMBER
# 71092
