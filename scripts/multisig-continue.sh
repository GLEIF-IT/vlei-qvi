#!/bin/bash

##################################################################
##                                                              ##
##      Script for continuing a multisig event process          ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

read -p "Enter the Alias to continue: " -r alias

kli multisig continue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${alias}"
