#!/bin/bash

##################################################################
##                                                              ##
##       Script for joining legal entity credential             ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"


read -p "Enter the filename of the new credential: " -r filename

kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --credential @"${filename}"
