# ssh, proxy, reverse proxy, port mapping

# on foreign machine to connect to from host server
ssh -R 9999:localhost:22 home_server

        ^              ^
        |              |
    port on home    sshd port on
    server that    foreign machine
    will tunnel    listening for
    to foreign     connections
    machine



# one home server
ssh home_server
ssh localhost -p 9999


