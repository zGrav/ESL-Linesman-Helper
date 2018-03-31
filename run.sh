#!/bin/bash

if [ -z "$1" ]
  then
    echo -e "\033[1;31mNo argument supplied."
		echo -e "\033[1;37mHow to use: ./run.sh <name of command to search> e.g ./run.sh jumpthrow"
		echo -e "\033[1;37mYes, you can use multiple searches. e.g ./run.sh jumpthrow attack"
		echo -e "\033[1;37mThis script assumes that all Linesman folders will be in <USER_DIR>/Downloads."
		exit 1
fi

DIRCOUNT=$(find ~/Downloads/ -type d -name "linesman*" -print | wc -l)

if [ "$DIRCOUNT" -eq 0 ]
  then
    echo -e "\033[1;31mNo Linesman folders found in <USER_DIR>/Downloads."
    exit 1
fi

find ~/Downloads/linesman* -type d -exec chmod -R 777 {} +

USERID=$(find ~/Downloads/linesman* -type f -execdir grep -rnw {} -e "User Id:" \;)
MATCHID=$(find ~/Downloads/linesman* -type f -execdir grep -rnw {} -e "Match Id:" \;)

echo -e "\033[1;33m" $USERID
echo -e "\033[1;33m" $MATCHID

echo

USERIDCLEAN=$(awk '{print $3}' <<< $USERID)

echo -e "\033[1;32mPlayer Name on ESL: $(wget --quiet -O - https://play.eslgaming.com/player/"$USERIDCLEAN"/ \ | sed -n -e 's!.*<title>\(.*\)</title>.*!\1!p' | awk '{print $1}')"
echo -e "\033[1;32mCSGO SteamID: $(wget --quiet -O - https://play.eslgaming.com/player/gameaccounts/"$USERIDCLEAN"/ | grep "SteamID CS:GO" -A2 | grep "active_y.gif" | sed -e 's/<[^>]*>//g')"

echo

echo -e "\033[1;36m"

IFS='
' # to join "$*" with newline
find ~/Downloads/linesman* -type f -execdir grep -rnw {} -e "$*" \;
