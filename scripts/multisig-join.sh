#!/bin/bash

##################################################################
##                                                              ##
##              Script for join a multisig aid                  ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode=$(get_passcode $1)

kli multisig join --name "${QAR_NAME}" --passcode "${passcode}"
