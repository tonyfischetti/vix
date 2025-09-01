# bash, colors, echo with colors, escape sequences

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BYELLOW='\033[0;93m'
CYAN='\033[0;36m'
BCYAN='\033[0;96m'
NC='\033[0m'

echo -e "${RED}This is in red"
echo -e "${GREEN}This is in green"
echo -e "${YELLOW}Yellow"
echo -e "${BYELLOW}Bright yellow!"
echo -e "${CYAN}Cyan"
echo -e "${BCYAN}Bright cyan!"
echo -e "${NC}Back to normal!"
