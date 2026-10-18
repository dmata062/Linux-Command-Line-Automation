#!/bin/bash

playagain="yes"
wins=0
gamesplayed=0

while [ "$playagain" = "yes" ]; do
	gamesplayed=$((gamesplayed+1))
	attempts=7
	num=$((RANDOM % 50 + 1))
	echo "Welcome to the Bash Number Guessing Game"
	echo "Think of a number between 1 and 50."
	echo "You have 7 attempts to guess it!"

	while [ "$attempts" -ge 1 ]; do
		echo "Enter Your Guess: "
		read guess
		if [ "$guess" -gt 50 ] || [ "$guess" -lt 1 ]; then
			echo "Invalid input! Please enter a number between 1 and 50"
			attempts=$((attempts-1))
			echo "Attempts remaining: $attempts"
		elif [ "$guess" -gt "$num" ]; then
			echo "Too high! Try a lower number."
			attempts=$((attempts-1))
                	echo "Attempts remaining: $attempts"
		elif [ "$guess" -lt "$num" ]; then
			echo "Too low! Try a higher number."
                	attempts=$((attempts-1))
                	echo "Attempts remaining: $attempts"
		else
			echo "Congratulations you guessed the number in $((7-attempts+1)) attempts!"
			wins=$((wins+1))
			break
		fi
	done

	if [ "$attempts" -eq 0 ]; then 
		echo "Game Over! The number was $num. Better luck next time!"
	fi

	echo "Would you like to play again? (yes/no): "
	read playagain
done

echo "Thanks for playing!"
echo "Wins: $wins"
echo "Games Played: $gamesplayed"
