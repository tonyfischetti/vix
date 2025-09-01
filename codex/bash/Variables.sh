# bash, variables, interpolation, defaults

VAR1="abc"
echo "$VAR1 is ${#VAR1} characters"

VAR2=""
VAR3="${VAR2:-default}"
echo $VAR3

echo "${VAR2:-default, again}"

