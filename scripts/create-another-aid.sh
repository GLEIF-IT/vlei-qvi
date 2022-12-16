#!/bin/bash

##################################################################
##                                                              ##
##        Script for creating another AID                       ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode=$(get_passcode $1)
salt=$(get_salt $1)

# Test to see if this script has already been run:
OUTPUT=$(kli list --name "${QAR_NAME}" --passcode "${passcode}")
ret=$?
if [ $ret -ne 0 ]; then
   echo "Need to run create-local-aid first."
   exit 69
fi

# Create another AID, using same DB as the main AID
kli incept --name "${QAR_NAME}" --alias "${QAR_ALIAS}" --passcode "${passcode}" --file ${QAR_SCRIPT_DIR}/qar-local-incept.json

# Here's your AID:
kli status --name "${QAR_NAME}" --alias "${QAR_ALIAS}" --passcode "${passcode}"