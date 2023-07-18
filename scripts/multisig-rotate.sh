#!/bin/bash

##################################################################
##                                                              ##
##             Script for rotating multisig aid                 ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

kli multisig rotate  --name "${QAR_NAME}" --passcode "${passcode}"  --alias "${QAR_AID_ALIAS}" "$@"
