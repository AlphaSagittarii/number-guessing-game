#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"
RANDOM_NUMBER=(($RANDOM % 1000))

echo "Enter your username:"
read USER_NAME

# check if user exists
USER_EXISTS=$($PSQL "")
if [[ -z $USER_EXISTS ]]
then
  # user doesn't exist
  Welcome, $USER! It looks like this is your first time here.
else
  # user exists
  echo Welcome back, $USER! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.
fi

# guess the number
echo "Guess the secret number between 1 and 1000:"
read GUESS
while $RANDOM_NUMBER != $GUESS
do
  # if number higher than guess
  if [[ $GUESS > $RANDOM_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
    read GUESS
  #if number lower than guess
  else if [[ $GUESS < $RANDOM_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
    read GUESS
  # if number not int
  else if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  # if number guessed
  else
   echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
  fi 
done