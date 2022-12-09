#!/bin/bash

##################################################################
##                                                              ##
##          Script for executing random kli commands            ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

# Run the sub command
kli "$@" --name "${QAR_NAME}" --passcode "${passcode}"