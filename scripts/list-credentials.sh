#!/bin/bash

##################################################################
##                                                              ##
##                Script for listing credentials                ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

# Here's your credentials:
kli vc list --name "${QAR_NAME}" --alias="${QAR_ALIAS}" --passcode "${passcode}" --poll