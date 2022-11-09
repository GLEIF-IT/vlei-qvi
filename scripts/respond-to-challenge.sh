#!/bin/bash

##################################################################
##                                                              ##
##      Script for resolving OOBIs of other participants        ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode=$(get_passcode $1)

read -p "Type or paste challenge sent to you: " -r words
read -p "Enter the Alias who sent you the words: " -r alias

echo " "
kli challenge respond --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_ALIAS}" --words "${words}" --recipient "${alias}"
echo "Challenge phrase signed and sent"