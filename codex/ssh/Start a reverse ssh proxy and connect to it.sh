# ssh, proxy, reverse proxy, port mapping

# "server"
ssh -R 9999:localhost:8888 betaoutside

# "client"
ssh betaoutside
ssh localhost -p 9898


