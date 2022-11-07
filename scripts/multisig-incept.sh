#!/bin/bash

##################################################################
##                                                              ##
##             Script for creating multisig aid                 ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode=$(get_passcode $1)

read -p "Enter an Alias for the Group Multisig AID: " -r alias
read -p "Enter the filename of the inception configuration file: " -r filename

kli multisig incept  --name "${QAR_NAME}" --passcode "${passcode}"  --alias "${QAR_ALIAS}" --group "${alias}" --file "${filename}"
