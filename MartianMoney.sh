#!/bin/bash

# Exchange $ to MartianMoney with for loop
function ForLoopMartianMoney() {
  input=$1 # Pass input param to function
  MartianMoney=("tintina" "sutton" "knorr" "wernicke")
  MartianMoneyValueToDollar=(80 16 8 1)

  # Calculate the number of MartianMoney
  for (( i=0; i<=3; i++ ))
  do
    myresult[i]=`expr $input / ${MartianMoneyValueToDollar[$i]}`
    input=`expr $input % ${MartianMoneyValueToDollar[$i]}`
  done

  # Format the output
  for (( i=0; i<${#MartianMoney[@]}; i++ ))
  do
    if [[ ${myresult[i]} -ne 0 ]]; then
      merged_array[i]="${myresult[i]} ${MartianMoney[i]}"
    fi
  done
  echo "\$$1 is ${merged_array[@]}"
}

# Main function
echo "Would you like to randomly enter a dollar amount (1) or enter it yourself (2)?"
read Selector
if [[ $Selector -eq 2 ]]; then
  echo "Enter a dollar amount between \$80 and \$10,000,000."
  read input 
  if [[ $input -ge 80 && $input -le 10000000 ]]; then
    ForLoopMartianMoney $input
  else 
    echo "Incorrect input!"
  fi
elif [[ $Selector -eq 1 ]] ; then
  random_input=`shuf -i 80-10000000 -n 1`
  echo $random_input
  ForLoopMartianMoney $random_input
else
  echo "Wrong option!"
fi
