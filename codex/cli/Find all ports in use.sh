# lsof, port, find all ports used

lsof -i -P -n | grep LISTEN

# or, if `ss` is available
ss -tulpn
