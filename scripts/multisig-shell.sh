#!/bin/bash

##################################################################
##                                                              ##
##           Script for running the multisig shell              ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

kli multisig shell --name "${QAR_NAME}" --passcode "${passcode}"
