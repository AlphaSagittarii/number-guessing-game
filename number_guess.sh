#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER=$(( (RANDOM % 1000) + 1 ))
echo $RANDOM_NUMBER


echo "Enter your username:"
read USER_NAME

LAST_GAME=$($PSQL "SELECT game_result FROM users WHERE user_name = '$USER_NAME'")
GAMES_PLAYED=$($PSQL "SELECT number_of_games FROM users WHERE user_name = '$USER_NAME'")
# check if user exists
USER_EXISTS=$($PSQL "SELECT * FROM users WHERE user_name = '$USER_NAME'")
if [[ -z $USER_EXISTS ]]
then
  # user doesn't exist
  echo "Welcome, $USER_NAME! It looks like this is your first time here."
  INSERT_USER=$($PSQL "INSERT INTO users(user_name) VALUES('$USER_NAME')")
else
  # user exists
  echo "Welcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $LAST_GAME guesses."
fi

# guess the number
echo "Guess the secret number between 1 and 1000:"
read GUESS
COUNT=1
while [[ $RANDOM_NUMBER != $GUESS ]]
do
  # if number not int
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    read GUESS
  # if number higher than guess
  elif [[ $GUESS -gt $RANDOM_NUMBER ]]
  then
    COUNT=$((COUNT + 1))
    echo "It's lower than that, guess again:"
    read GUESS
  #if number lower than guess
  elif [[ $GUESS -lt $RANDOM_NUMBER ]]
  then
    COUNT=$((COUNT + 1))
    echo "It's higher than that, guess again:"
    read GUESS
  fi 
done
# if number guessed
echo "You guessed it in $COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
INSERT_GAME_COUNT=$($PSQL "UPDATE users SET number_of_games = number_of_games + 1 WHERE user_name = '$USER_NAME'")
if [[ $COUNT -gt $LAST_GAME ]]
then
  UPDATE_GAME_RESULT=$($PSQL "UPDATE users SET game_result = $COUNT WHERE user_name = '$USER_NAME'")
fi


