#!/bin/bash

##################################################################
##                                                              ##
##        Script for creating local External QAR AID            ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode="$(security find-generic-password -w -a "${LOGNAME}" -s qar-passcode)"
salt="$(security find-generic-password -w -a "${LOGNAME}" -s qar-salt)"

# Test to see if this script has already been run:
OUTPUT=$(kli list --name "${QAR_NAME}" --passcode "${passcode}")
ret=$?
if [ $ret -eq 0 ]; then
   echo "Local AID for ${QAR_NAME} already exists, exiting:"
   printf "\t%s\n" "${OUTPUT}"
   exit 69
fi

# Create the local database environment (directories, datastore, keystore)
kli init --name "${QAR_NAME}" --salt "${salt}" --passcode "${passcode}" --config-dir /scripts --config-file ext-qar-config.json

# Create your local AID for use as a participant in the External AID
kli incept --name "${QAR_NAME}" --alias "${QAR_ALIAS}" --passcode "${passcode}" --file /scripts/ext-qar-local-incept.json

# Here's your AID:
kli status --name "${QAR_NAME}" --alias "${QAR_ALIAS}" --passcode "${passcode}"