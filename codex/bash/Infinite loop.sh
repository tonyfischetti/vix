# bash, infinite loop, while true, waiting, elif, confirm

resp="!!!"
while true; do
    read -r -p "Confirm: (Y/n) " resp
    if [ $resp ]; then
        if [ $resp == "Y" ]; then
            break
        elif [ $resp == "n" ] || [ $resp == "N" ]; then
            echo "exiting"
            exit 1
        fi
    fi
done

echo "end"

# you can also use this to wait for things to
# change status (using `sleep x`), etc...

