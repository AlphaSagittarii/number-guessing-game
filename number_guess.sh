#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER=$(( (RANDOM % 1000) + 1 ))
echo $RANDOM_NUMBER

echo "Enter your username:"
read USER_NAME

# check if user exists
USER_EXISTS=$($PSQL "SELECT * FROM users WHERE user_name = '$USER_NAME'")
if [[ -z $USER_EXISTS ]]
then
  # user doesn't exist
  echo "Welcome, $USER_NAME! It looks like this is your first time here."
else
  # user exists
  echo Welcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.
fi

# guess the number
echo "Guess the secret number between 1 and 1000:"
read GUESS
COUNT=0
while [[ $RANDOM_NUMBER != $GUESS ]]
do
  # if number higher than guess
  if [[ $GUESS -gt $RANDOM_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
    read GUESS
    $COUNT+=1
  #if number lower than guess
  elif [[ $GUESS -lt $RANDOM_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
    read GUESS
    $COUNT+=1
  # if number not int
  elif [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    read GUESS
  fi 
done
# if number guessed
echo "You guessed it in $COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
