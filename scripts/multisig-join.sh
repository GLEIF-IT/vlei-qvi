#!/bin/bash

##################################################################
##                                                              ##
##              Script for join a multisig aid                  ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode="$(security find-generic-password -w -a "${LOGNAME}" -s qar-passcode)"

kli multisig join --name "${QAR_NAME}" --passcode "${passcode}"
