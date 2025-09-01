# bash, mktemp, temporary files, trap, cleanup

tempfile=$(mktemp)
echo $tempfile
trap "rm -f $tempfile" EXIT

echo "::alice glass:: HI!" > $tempfile
cat $tempfile
sleep 2
mv $tempfile ./TEMPFILE

# `mktemp -d` makes a temporary directory
