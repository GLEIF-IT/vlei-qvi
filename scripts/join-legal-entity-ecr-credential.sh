#!/bin/bash

##################################################################
##                                                              ##
##          Script for joining legal entity ecr                 ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

read -p "Enter the LEI of the new Legal Entity: " -r lei
read -p "Enter person legal name: " -r personLegalName
read -p "Enter engagement context role: " -r engagementContextRole
read -p "Enter the alias of the recipient of ECR credential: " -r recipient

echo \'[\"${lei}\", \"${personLegalName}\", \"${engagementContextRole}\"]\' | jq -f "${QAR_SCRIPT_DIR}/legal-entity-ecr-data.jq" > "${QAR_DATA_DIR}/legal-entity-ecr-data.json"

kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_ALIAS}" --registry-name "${QAR_REG_NAME}" --schema ELqriXX1-lbV9zgXP4BXxqJlpZTgFchll3cyjaCyVKiz --recipient "${recipient}" --data @"${QAR_DATA_DIR}/legal-entity-ecr-data.json"
