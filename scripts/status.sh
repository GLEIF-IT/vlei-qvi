#!/bin/bash

##################################################################
##                                                              ##
##        Script for creating local External QAR AID            ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(security find-generic-password -w -a "${LOGNAME}" -s qar-passcode)"

# Here's your AID:
kli status --name "${QAR_NAME}" --alias "${QAR_ALIAS}" --passcode "${passcode}"