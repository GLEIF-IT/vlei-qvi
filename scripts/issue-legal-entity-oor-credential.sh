#!/bin/bash

##################################################################
##                                                              ##
##             Script for creating multisig aid                 ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode="$(get_passcode $1)"

read -p "Enter the LEI of the new Legal Entity: " -r lei
read -p "Enter the alias of the new Legal Entity: " -r recipient

echo \"${lei}\" | jq -f "${QAR_SCRIPT_DIR}/legal-entity-data.jq" > "${QAR_DATA_DIR}/legal-entity-data.json"

kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_ALIAS}" --registry-name "${QAR_REG_NAME}" --schema EIL-RWno8cEnkGTi9cr7-PFg_IXTPx9fZ0r9snFFZ0nm --recipient "${recipient}" --data @"${QAR_DATA_DIR}/legal-entity-oor-data.json"
