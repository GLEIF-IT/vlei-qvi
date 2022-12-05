#!/bin/bash

##################################################################
##                                                              ##
##      Script for generating your OOBI to send to others       ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

kli oobi generate --name "${QAR_NAME}" --passcode "${passcode}" --role witness
