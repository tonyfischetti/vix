# ssh, proxy, reverse proxy, tunnel

ssh -R PORT_ON_REMOTE_SERVER:localhost:SSH_PORT_ON_LOCAL_MACHINE

# remove server is the proxy server
# local machine is the machine you want to connect to through the proxy

# then, ssh into the proxy server
ssh PROXY_SERVER

# then ssh into port of reverse tunnel
ssh -p PORT_ON_REMOTE_SERVER localhost
