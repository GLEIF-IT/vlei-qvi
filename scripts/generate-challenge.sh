#!/bin/bash

##################################################################
##                                                              ##
##      Script for generating random challenge phrase           ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

read -p "Enter the Alias to whom you will send the words: " -r alias
echo " "
kli challenge verify --generate --out string --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_ALIAS}" --signer "${alias}"
