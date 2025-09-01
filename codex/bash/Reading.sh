# bash, read, reading input, test for empty string, prompt, sensitive, passwords, timeout

# -r = Disable backslashes to escape characters

read -r -p "Username: " USERNAME
read -r -s -p "FAKE password: " PASSWORD

printf "\nCreate user $USERNAME with pw $PASSWORD: (Y/n) "
read -r RESP
if [[ $RESP == "Y" ]]; then
    printf "OK!\n"
else
    printf "(cancelled)\n"
fi

read -r -t 5 -p "Give me input in 5 seconds or else! " ORELSE
if [ -z $ORELSE ]; then
    printf "\n:(\n"
    exit 1
else
    printf ":)\n"
fi

