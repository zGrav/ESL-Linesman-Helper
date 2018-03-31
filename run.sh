#!/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied."
		echo "How to use: ./run.sh <name of command to search> e.g ./run.sh jumpthrow"
		echo "Yes, you can use multiple searches. e.g ./run.sh jumpthrow attack"
		echo "This script assumes that all Linesman folders will be in <USER_DIR>/Downloads."
		exit 1
fi

find ~/Downloads/linesman* -type d -exec chmod -R 777 {} +

USERID=$(find ~/Downloads/linesman* -type f -execdir grep -rnw {} -e "User Id:" \;)
MATCHID=$(find ~/Downloads/linesman* -type f -execdir grep -rnw {} -e "Match Id:" \;)

echo $USERID
echo $MATCHID

echo

USERIDCLEAN=$(awk '{print $3}' <<< $USERID)

echo "Player Name on ESL: $(wget --quiet -O - https://play.eslgaming.com/player/"$USERIDCLEAN"/ \ | sed -n -e 's!.*<title>\(.*\)</title>.*!\1!p' | awk '{print $1}')"
echo "CSGO SteamID: $(wget --quiet -O - https://play.eslgaming.com/player/gameaccounts/"$USERIDCLEAN"/ | grep "SteamID CS:GO" -A2 | grep "active_y.gif" | sed -e 's/<[^>]*>//g')"

echo

IFS='
' # to join "$*" with newline
find ~/Downloads/linesman* -type f -execdir grep -rnw {} -e "$*" \;
