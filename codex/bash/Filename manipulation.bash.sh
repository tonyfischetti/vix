# bash, filename manipulation, remove extension, change extension,
# basename

TF="$0"
FTF="$(realpath "${TF}")"    #  WARNING  THIS MUST BE QUOTED, AGAIN!

printf "This is the filename of the currently running script:\n$0\n\n"

echo "Full:         $FTF"
echo "Path to file: ${FTF%/*}"
echo "Basename:     ${FTF##*/}"
echo "No extension: ${TF%.*}"
echo "No ext (all): ${TF%%.*}"
echo "Extension:    ${TF##*.}"
