array=("item 1" "item 2" "item 3")

for i in "${array[@]}"; do   # The quotes are necessary here
    echo "$i"
done
