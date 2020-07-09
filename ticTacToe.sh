#!/bin/bash -x
tput clear
echo "Welcome to the TIC TAC TOE GAME SIMULATOR"

function createBoardReset()
{
        board=( " " 1 2 3 4 5 6 7 8 9 )
        echo "Game is Starting now........."
}

function createBoard()
{
        echo "${board[1]} | ${board[2]} | ${board[3]}"
        echo "-----------"
        echo "${board[4]} | ${board[5]} | ${board[6]}"
        echo "-----------"
        echo "${board[7]} | ${board[8]} | ${board[9]}"

}

function toss()
{
	toss=$((RANDOM%2))
	if(($toss==0))
	then
        	echo "Player won the toss, Player will play first"
	else
        	echo "Computer won the toss, Computer will play first"
	fi
}

function assignValue()
{
	if(($toss==0))
        then
                echo "What do you want to choose : for x press 1 , for 0 press 2 ?"
                read user
                if(($user==1))
                then
                        playerValue=x
                        computerValue=0
                elif(($user==2))
                then
                        playerValue=0
                        computerValue=x
                fi
		echo "player is assigned $playerValue and computer is assigned $computerValue"
	else
        	playerValue=x
        	computerValue=0
        	echo "player is assigned $playerValue and computer is assigned $computerValue"
	fi
}

createBoard
createBoardReset
echo "Setting up the board and creating"
sleep 1
createBoard
toss
assignValue
createBoard
