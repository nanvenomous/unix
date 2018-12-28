source ./declaration.sh

echo '${array[@]}' 
echo -e "\t\t" ${array[@]}

echo '${array[4]}' 
echo -e "\t\t" ${array[4]}

echo '${#array[@]}' 
echo -e "\t\t" ${#array[@]}

echo '${#array[4]}' 
echo -e "\t\t" ${#array[4]}

echo '${array[@]:1:2}' 
echo -e "\t\t" ${array[@]:1:2}

echo '${array[0]:1:3}' 
echo -e "\t\t" ${array[0]:1:3}

echo '${array[@]/Ubuntu/childProof}'
echo -e "\t\t" ${array[@]/Ubuntu/childProof}

