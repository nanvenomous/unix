#!/bin/bash

array=( "Vietnam" "Germany" "Argentina" )
array2=( "Asia" "Europe" "America" )

for ((i=0;i<${#array[@]};++i)); do
    printf "%s is in %s\n" "${array[i]}" "${array2[i]}"
done
