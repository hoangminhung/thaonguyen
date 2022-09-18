# type=4

# MartianMoney=("tintina" "sutton" "knorr" "wernicke")
# myresult=(0 0 0 0)
# # for index in ${!myArray[@]}; do
# #   # echo "`expr $1 / ${myArray[$index]}` ${MartianMoney[$index]}"
# #   echo ${myArray[$index]}
# # done
# n=81
# echo "mang truoc khi add data ${myresult[@]}"
# for (( i=0; i<=3; i++ ))
# do
#   myresult[i]=`expr $n  / ${myArray[$i]}`
#   n=`expr $n % ${myArray[$i]}`
# done

# for index in ${!MartianMoney[@]}; do
#   echo "${myresult[$index]} ${MartianMoney[$index]}"
# done

# echo "${myresult[@]} ${MartianMoney[@]}"

# # len=${#MartianMoney[@]}
# # index=0
# # while [ $index -lt $len ]
# # do
# #   echo "${myresult[$index]} ${MartianMoney[$index]}"
# #   index=$(( $index + 1 ))
# # # myresult=(${MartianMoney[@]})
# # done

# # echo "mang sau khi add data ${myresult[@]}"
# # len=${#MartianMoney[@]}

# # echo "$len"

# # echo ${myArray[ 4 - 4 ]}



# ## Read line and print line with for and while
# # read line 
# # list=(${line})

# # for i in ${list[@]};do
# #   echo $i
# # done

# # while read line
# # do
# #     my_array=("${my_array[@]}" $line)
# # done

# # echo ${my_array[@]}


# ## random number with bash shell
# random=`shuf -i 0-1000 -n 1`
# echo $random

number=(80 0 0 1)
char=("tintina" "sutton" "knorr" "wernicke")

if [[ ${#number[@]} == ${#char[@]} ]]; then
  for (( i=0; i<${#number[@]}; i++ ))
  do
    if [[ ${number[i]} -ne 0 ]]; then
      merged_string[i]="${number[i]} ${char[i]}"
    fi
  done
fi
echo ${merged_string[@]} 
