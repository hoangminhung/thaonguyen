#!/bin/bash
# read a
# read b 
# echo "$a chia $b lấy kết quả nguyên : `expr $a / $b` "
# echo "$a chia $b lấy số dư `expr $a % $b`"

## Array
# Declare an array
number_array=(80 16 8 1)
char_array=("tintina" "sutton" "knorr" "wernicke")
mixed_array=(80 "tintina" "sutton" 16)
# print full array
echo ${number_array[@]}
echo ${char_array[@]}
echo ${mixed_array[@]}

# print 1 element in array
echo ${number_array[1]}
echo ${char_array[0]}
echo ${mixed_array[2]}

# update value in array
number_string[0]="new value"
echo ${number_array[@]}

# Merged 2 array with same len
if [[ ${#number_array[@]} == ${#char_array[@]} ]]; then
  for (( i=0; i<${#number_array[@]}; i++ ))
  do
    merged_string[i]="${number_array[i]} ${char_array[i]}"
  done
fi
echo ${merged_string[@]} 

## Condition for Intergers comparation
# -eq # Equal
# -ne # Not equal
# -lt # Less than
# -le # Less than or equal
# -gt # Greater than
# -ge # Greater than or equal
