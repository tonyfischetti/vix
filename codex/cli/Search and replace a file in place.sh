# perl, sed, search and replace in place, inplace, in-place .bak

perl -pi -e 's/this/that/' FILE
perl -pi.bak -e 's/this/that/' FILE     # renames original before editing

perl -0777 -pi.bak -e 's/mult.will/ONELINE!/s'   test # . will match newlines (with /s)
perl -0777 -pi.bak -e 's/one\ntwo/TWO\nLINES!/s' test

# -0777 changes the $/ (input record separator) to `undef`

# /s: Makes the dot match newline characters.
# /m: Changes the behavior of ^ and $ to match the start 
#     and end of lines instead of the whole string.
