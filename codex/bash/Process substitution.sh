# bash, process substitution, diff

diff --color <(ls ../js) <(ls ../haskell)

# here `<(ls ../js)` is treating the output as if it
# were the contents of a file
