#!/bin/bash

##################################################################
##                                                              ##
##          Script for issuing ecr auth                         ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

read -p "Enter your LEI : " -r lei
read -p "Enter or Paste the AID of the recipient of the OOR credential: " -r AID
read -p "Enter requested person legal name: " -r personLegalName
read -p "Enter requested engagement context role: " -r engagementContextRole

# Prepare DATA Section
echo "[\"${AID}\", \"${lei}\", \"${personLegalName}\", \"${engagementContextRole}\"]" | jq -f "${QAR_SCRIPT_DIR}/ecr-auth-data.jq" > "${QAR_DATA_DIR}/ecr-auth-data.json"

read -p "Enter AID of QVI : " -r recipient

# Prepare the EDGES Section
le_said=$(kli vc list --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --said --schema ENPXp1vQzRF6JwIuS-mp2U8Uf1MoADoP_GqQ62VsDZWY  | tr -d '\r')

echo "\"${le_said}\"" | jq -f "${QAR_SCRIPT_DIR}/ecr-auth-edges-filter.jq" > "${QAR_DATA_DIR}/ecr-auth-edge-data.json"
kli saidify --file data/ecr-auth-edge-data.json

# wip
kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --registry-name "${QAR_REG_NAME}" --schema ED_PcIn1wFDe0GB0W7Bk9I4Q_c9bQJZCM2w7Ex9Plsta --recipient "${recipient}" --data @"data/ecr-auth-data.json" --edges @"data/ecr-auth-edge-data.json" --rules @"data/rules.json" --out "data/credential.json"
