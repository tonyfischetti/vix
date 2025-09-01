# bash, conditionals, test, square brackets, test for empty string

# (look at man test)

if test -f Conditionals.sh; then
    echo "this file exists (and is regular file)"
fi

# single square bracket is equivalent to `test`

if [ -f Conditionals.sh ]; then
    echo "this file exists (and is regular file)"
fi

if [ -L "$HOME/.zshrc" ]; then
    echo "$HOME/.zshrc is a symbolic link"
fi

ZSHCANONICALLOC="$HOME/.zsh/.zshrc"
if [ $ZSHCANONICALLOC = $(readlink $HOME/.zshrc) ]; then
    echo "zshrc is properly linked"
fi

if [ -L "$HOME/.zshrc" ] && [ $ZSHCANONICALLOC = $(readlink $HOME/.zshrc) ]; then
    echo "$HOME/.zshrc is both"
fi

if [ 2 -gt 1 ]; then echo "two is more than one"; fi


if fd -q Conditionals.sh ../; then
    echo "there's a file called Conditional.sh in the parent folder"
else
    echo "there's NO file called Conditional.sh in the parent folder"
fi


# double square brackets let you do patterns
# (e.g. `if [[ $FILE == *.sh ]]`)

