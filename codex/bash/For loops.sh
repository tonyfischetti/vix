# bash, for loops, print without filename, nullglob, dotglob, print all files in directory

for i in {5..1}; do
    echo $i
done
echo "liftoff"

#  WARNING  this only works for files with no spaces in them
echo "(Warning) This directory has the following .sh files: "
for item in *.sh; do
    echo "  - ${item%.*}"   
done


#  NOTICE  BETTER WAY

shopt -s nullglob dotglob

# nullglob: if a glob pattern has no matches,
#           it expands to nothing (the empty list)
#           instead of staying as the literal text
#
# dotglob: globs like * and *.txt include dotfiles
#          (names starting with .) in matches
#          [except . and ..]

printf "\n\n The parent directory has:\n"
files=(../**/*)
for item in "${files[@]}"; do
    if [[ -f $item ]]; then
        echo "  - ${item##*/}"
    fi
done

