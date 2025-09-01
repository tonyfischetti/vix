# bash, redirection, redirect stdout to /dev/null, redirect stderr to /dev/null, redirect both stdout and stderr to /dev/null, echo to stderr

# redirect stdout
curl ifconfig.me > /dev/null

# redirect stderr
curl ifconfig.me 2> /dev/null

# echo something to stderr
echo "ERROR!" >&2

# redirect both
if ack TODO "${CODEBASEDIR:-../}" >/dev/null 2>&1; then
    echo "There's a TODO in this codebase"
fi
