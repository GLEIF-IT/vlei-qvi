#!/bin/bash

##################################################################
##                                                              ##
##        Script for getting local status                       ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

# Here's your AID:
kli status --name "${QAR_NAME}" --passcode "${passcode}"
