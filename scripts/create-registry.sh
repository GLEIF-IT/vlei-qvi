#!/bin/bash

##################################################################
##                                                              ##
##             Script for creating registry                     ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

read -p "Type or paste a nonce: " -r nonce

kli vc registry incept  --name "${QAR_ALIAS}" --passcode "${passcode}"  --alias "${QAR_ALIAS}" --registry-name "${QAR_REG_NAME}" --nonce "${nonce}"
