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

function assignValue()
{
	if(($toss==0))
	then
        	echo "what do you want to choose x(press 1) else for 0(press 2):"
        	read user

		if (($user == 1))
        	then
                	playerValue=x
                	computerValue=0
        	elif(($user == 2))
        	then
                	playerValue=0
                	computerValue=x
        	fi
        	echo "player is assigned $playerValue and computer is assigned $computerValue"
	else
	user=1
        playerValue=x
        computerValue=0
        echo "player is assigned $playerValue and computer is assigned $computerValue"
	fi
}

function tossVal()
{
	toss=$((RANDOM%2))
	if(($toss==0))
	then
        	echo "Player won the toss, player will play first"
	else
        	echo "Computer won the toss, computer will play first"
	fi
}

createBoard
createBoardReset
echo "Setting up the board and creating"
sleep 1
createBoard
sleep 1
tossVal
sleep 1
assignValue

echo "COMPUTER IS PLAYING LIKE ME ONLY"
function repeatPlayerComputer()
{
	for value in ${filled[@]}
	do
		if(($value==$place))
		then
			playerCheck=0
			computerCheck=0
			break
		else
			playerCheck=1
			computerCheck=1
		fi
	done
}

leftPlayer=6
function playerPlay()
{
	filled+=( 0 )
	playerCheck=0
	echo "enter the place where you want to put you value"
	echo "choose from left outs ---------->> ${board[@]}"
	read place
	repeatPlayerComputer
	while(($playerCheck==0))
	do
		repeatPlayerComputer
		echo "enter new value where you want to put out of ${board[@]}"
		read place
		repeatPlayerComputer
		continue

	done
	echo "player choosed $place"
	unset -v 'board[$place]'
	board[$place]=$playerValue
	filled+=( $place )
	createBoard
	let "leftPlayer=leftPlayer-1"
}

selfWin=0
function computerWinCheck()
{
	if(($user == 1))
	then
                if [[ ${board[$1]} == 0 ]]
                then
                        if [[ ${board[$2]} == 0 ]]
                        then
				place=$3
				repeatPlayerComputer
				if(($computerCheck==1))
                                then
                                        unset -v 'board[$3]'
                                        board[$3]=0
                                        selfWin=1
                                fi
			fi
                fi
	elif(($user == 2))
	then
		if [[ ${board[$1]} == x ]]
                then
                        if [[ ${board[$2]} == x ]]
                        then
				place=$3
				repeatPlayerComputer
				if(($computerCheck==1))
				then
					unset -v 'board[$3]'
        	                        board[$3]=x
					selfWin=1
                		fi
		        fi
                fi
	fi
}

selfBlock=0
gameOver=0
function blockUser()
{
        if(($user == 1))
        then
                if [[ ${board[$1]} == x ]]
                then
                        if [[ ${board[$2]} == x ]]
                        then
                                place=$3
                                repeatPlayerComputer
                                if(($computerCheck==1))
                                then
                                        if(($selfWin==1))
                                        then
                                                gameOver=1
                                        else
                                                unset -v 'board[$3]'
                                                board[$3]=0
                                                selfBlock=1
                                        fi
                                fi
                        fi
                fi
        elif(($user == 2))
        then
                if [[ ${board[$1]} == 0 ]]
                then
                        if [[ ${board[$2]} == 0 ]]
                        then
                                place=$3
                                repeatPlayerComputer
                                if(($computerCheck==1))
                                then
                                        if(($selfWin==1))
                                        then
                                                gameOver=1
                                        else
                                                unset -v 'board[$3]'
                                                board[$3]=x
                                                selfBlock=1
                                        fi
                                fi
                        fi
                fi
        fi
}

function checkComputerWin()
{
        computerWinCheck 1 2 3	computerWinCheck 2 3 1	computerWinCheck 3 1 2	computerWinCheck 3 2 1	computerWinCheck 2 1 3	computerWinCheck 1 3 2
	computerWinCheck 4 5 6	computerWinCheck 5 6 4	computerWinCheck 6 4 5	computerWinCheck 6 5 4	computerWinCheck 5 4 6	computerWinCheck 4 6 5
       	computerWinCheck 7 8 9	computerWinCheck 8 9 7	computerWinCheck 9 7 8	computerWinCheck 9 8 7	computerWinCheck 8 7 9	computerWinCheck 7 9 8
        computerWinCheck 1 4 7	computerWinCheck 4 7 1	computerWinCheck 7 1 4	computerWinCheck 7 4 1	computerWinCheck 4 1 7	computerWinCheck 1 7 4
        computerWinCheck 2 5 8	computerWinCheck 5 8 2	computerWinCheck 8 2 5	computerWinCheck 8 5 2	computerWinCheck 5 2 8	computerWinCheck 2 8 5
        computerWinCheck 3 6 9	computerWinCheck 6 9 3	computerWinCheck 9 3 6	computerWinCheck 9 6 3	computerWinCheck 6 3 9	computerWinCheck 3 9 6
        computerWinCheck 1 5 9	computerWinCheck 5 9 1	computerWinCheck 9 1 5	computerWinCheck 9 5 1	computerWinCheck 5 1 9	computerWinCheck 1 9 5
        computerWinCheck 3 5 7	computerWinCheck 5 7 3	computerWinCheck 7 3 5	computerWinCheck 7 5 3	computerWinCheck 5 3 7	computerWinCheck 3 7 5
}

function checkBlockUser()
{
        blockUser 1 2 3	blockUser 2 3 1	blockUser 3 1 2	blockUser 3 2 1	blockUser 2 1 3	blockUser 1 3 2
        blockUser 4 5 6	blockUser 5 6 4	blockUser 6 4 5	blockUser 6 5 4	blockUser 5 4 6	blockUser 4 6 5	
	blockUser 7 8 9	blockUser 8 9 7	blockUser 9 7 8	blockUser 9 8 7	blockUser 8 7 9	blockUser 7 9 8
        blockUser 1 4 7	blockUser 4 7 1	blockUser 7 1 4	blockUser 7 4 1	blockUser 4 1 7	blockUser 1 7 4
        blockUser 2 5 8	blockUser 5 8 2	blockUser 8 2 5	blockUser 8 5 2	blockUser 5 2 8	blockUser 2 8 5
        blockUser 3 6 9	blockUser 6 9 3	blockUser 9 3 6	blockUser 9 6 3	blockUser 6 3 9	blockUser 3 9 6
        blockUser 1 5 9	blockUser 5 9 1	blockUser 9 1 5	blockUser 9 5 1	blockUser 5 1 9	blockUser 1 9 5
        blockUser 3 5 7	blockUser 5 7 3	blockUser 7 3 5	blockUser 7 5 3	blockUser 5 3 7	blockUser 3 7 5
}

leftComputer=6
function computerPlay()
{
	filled+=( 0 )
	computerCheck=0
	echo "------------------------------------------------------------------"
	echo "computer is choosing the place"
	echo "choosing from the left outs ------------>> ${board[@]}"
	checkComputerWin
	checkBlockUser
	if(($selfWin==1))
	then
		echo "Winning board is"
		createBoard
		echo "Computer is winner"
		exit
	elif(($selfBlock==1))
        then
                echo "Computer blocked you"
	else
		place=$((RANDOM%9 + 1))
	fi

	repeatPlayerComputer
	while(($computerCheck==0))
	do
                repeatPlayerComputer
		checkComputerWin
		checkBlockUser
		if(($selfWin==1))
		then
                        echo "Winning board is"
                        createBoard
                        echo "Computer is winner"
       	                exit
		elif(($selfBlock==1))
                then
                        gameOver=1
		else
			place=$((RANDOM%9 + 1))
		fi
                repeatPlayerComputer
		continue
	done
	echo "computer choosed $place"
	unset -v 'board[$place]'
        board[$place]=$computerValue
	filled+=( $place )
	createBoard
	let "leftComputer=leftComputer-1"
}

winPlayer=0
winComputer=0
function testWin()
{
	if(($toss==0 || $toss==1))
        then

                if [[ ${board[$1]} == 0 ]]
                then
			if [[ ${board[$2]} == 0 ]]
			then
				if [[ ${board[$3]} == 0 ]]
				then
                        		winPlayer=1
					winComputer=1
				fi
			fi
		elif [[ ${board[$1]} == x ]]
		then
			if [[ ${board[$2]} == x ]]
			then
				if [[ ${board[$3]} == x ]]
				then
					winComputer=1
					winPlayer=1
				fi
			fi
		fi
	fi
}

function checkWin()
{
	testWin 1 2 3 testWin 2 3 1 testWin 3 1 2 testWin 3 2 1 testWin 2 1 3 testWin 1 3 2
	testWin 4 5 6 testWin 5 6 4 testWin 6 4 5 testWin 6 5 4 testWin 5 4 6 testWin 4 6 5
	testWin 7 8 9 testWin 8 9 7 testWin 9 7 8 testWin 9 8 7 testWin 8 7 9 testWin 7 9 8
	testWin 1 4 7 testWin 4 7 1 testWin 7 1 4 testWin 7 4 1 testWin 4 1 7 testWin 1 7 4
	testWin 2 5 8 testWin 5 8 2 testWin 8 2 5 testWin 8 5 2 testWin 5 2 8 testWin 2 8 5
	testWin 3 6 9 testWin 6 9 3 testWin 9 3 6 testWin 9 6 3 testWin 6 3 9 testWin 3 9 6
	testWin 1 5 9 testWin 5 9 1 testWin 9 1 5 testWin 9 5 1 testWin 5 1 9 testWin 1 9 5
	testWin 3 5 7 testWin 5 7 3 testWin 7 3 5 testWin 7 5 3 testWin 5 3 7 testWin 3 7 5
}

if(($toss==0))
then
	while(($leftPlayer != 1))
	do
		playerPlay
		checkWin
		if(($winPlayer==1))
		then
			echo "--------------player is winner-------------------"
			exit
		fi
		if(($leftComputer!=2))
		then
			computerPlay
			sleep 1
			checkWin
	                if(($winComputer==1))
        	        then
        	                echo "--------------------computer is winner-------------------"
                	        exit
                	fi

		fi
	done
	echo "Game is tie !! no one is winner, Game is exiting"
	exit
else
	while(($leftComputer != 1))
	do
		computerPlay
		sleep 1
			checkWin
			if(($winComputer==1))
                        then
                                echo "---------------------------computer is winner----------------------------"
                                exit
                        fi
		if(($leftPlayer!=2))
		then
			playerPlay
			checkWin
			if(($winPlayer==1))
                        then
                                echo "-------------------------------player is winner------------------------------"
                                exit
                        fi
		fi
	done
	echo "game is tie !! no one is winner, Game is exiting"
	exit
fi

