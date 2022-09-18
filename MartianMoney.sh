#!/bin/bash

# Exchange $ to MartianMoney with for loop
function ForLoopMartianMoney() {
  myArray=(80 16 8 1)
  MartianMoney=("tintina" "sutton" "knorr" "wernicke")
  myresult=(0 0 0 0)
  n=$1
  for (( i=0; i<=3; i++ ))
  do
    myresult[i]=`expr $n  / ${myArray[$i]}`
    n=`expr $n % ${myArray[$i]}`
  done

  for index in ${!MartianMoney[@]}; do
    echo "${myresult[$index]} ${MartianMoney[$index]}"
  done
}

echo "Would you like to randomly enter a dollar amount (1) or enter it yourself (2)?"
read a
if [[ $a -eq 2 ]]; then
  echo "Enter a dollar amount between \$80 and \$10,000,000."
  read b 
  if [[ $b -ge 80 && $b -le 10000000 ]]; then
    ForLoopMartianMoney $b
  else 
    echo "Incorrect input"
  fi
elif [[ $a -eq 1 ]] ; then
  random=`shuf -i 80-10000000 -n 1`
  echo $random
  ForLoopMartianMoney $random
else
  echo "wrong input !"
fi


