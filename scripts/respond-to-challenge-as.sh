#!/bin/bash

##################################################################
##                                                              ##
##      Script for resolving OOBIs of other participants        ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

read -p "Respond to the challenge as which alias? " -r as
read -p "Type or paste challenge sent to you: " -r words
read -p "Enter the Alias who sent you the words: " -r alias

echo " "
kli challenge respond --name "${QAR_NAME}" --passcode "${passcode}" --alias "${as}" --words "${words}" --recipient "${alias}"
echo "Challenge phrase signed and sent"
