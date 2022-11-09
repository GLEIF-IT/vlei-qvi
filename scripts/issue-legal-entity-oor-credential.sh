#!/bin/bash

##################################################################
##                                                              ##
##          Script for issuing legal entity oor                 ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

read -p "Enter the LEI of the new Legal Entity: " -r lei
read -p "Enter person legal name: " -r personLegalName
read -p "Enter official role: " -r officialRole
read -p "Enter the alias of the recipient of OOR credential: " -r recipient

echo \'[\"${lei}\", \"${personLegalName}\", \"${officialRole}\"]\' | jq -f "${QAR_SCRIPT_DIR}/legal-entity-oor-data.jq" > "${QAR_DATA_DIR}/legal-entity-oor-data.json"

kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_ALIAS}" --registry-name "${QAR_REG_NAME}" --schema EBNaNu-M9P5cgrnfl2Fvymy4E_jvxxyjb70PRtiANlJy --recipient "${recipient}" --data @"${QAR_DATA_DIR}/legal-entity-oor-data.json"
