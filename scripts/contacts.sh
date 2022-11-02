#!/bin/bash

##################################################################
##                                                              ##
##      Script for listing aliases for remote contacts          ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode="$(security find-generic-password -w -a "${LOGNAME}" -s qar-passcode)"

echo ""
kli contacts list --name "${QAR_NAME}" --passcode "${passcode}" | jq '"Alias: "+.alias+"\n\rAID:   "+.id+"\n\rAuthenticated: "+ if .challenges | length > 0 then "True" else "False" end +"\n\r"' --raw-output
