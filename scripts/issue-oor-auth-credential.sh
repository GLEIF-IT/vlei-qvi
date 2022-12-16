#!/bin/bash

##################################################################
##                                                              ##
##          Script for issuing oor auth                         ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode=$(get_passcode $1)

read -p "Enter your LEI : " -r lei
read -p "Enter or Paste the AID of the recipient of the OOR credential: " -r AID
read -p "Enter requested person legal name: " -r personLegalName
read -p "Enter requested official role: " -r officialRole
read -p "Enter the Alias of the QVI to authorize with this AUTH credential: " -r recipient


# Prepare the DATA section
echo "[\"${AID}\", \"${lei}\", \"${personLegalName}\", \"${officialRole}\"]" | jq -f "${QAR_SCRIPT_DIR}/oor-auth-data.jq" > "${QAR_DATA_DIR}/oor-auth-data.json"

# Prepare the EDGES Section
le_said=$(kli vc list --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --said --schema ENPXp1vQzRF6JwIuS-mp2U8Uf1MoADoP_GqQ62VsDZWY  | tr -d '\r')

echo "\"${le_said}\"" | jq -f "${QAR_SCRIPT_DIR}/oor-auth-edges-filter.jq" > "${QAR_DATA_DIR}/oor-auth-edge-data.json"
kli saidify --file /data/oor-auth-edge-data.json

# Prepare the RULES section
cp "${QAR_SCRIPT_DIR}/rules.json" "${QAR_DATA_DIR}/rules.json"

kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --registry-name "${QAR_REG_NAME}" --schema EKA57bKBKxr_kN7iN5i7lMUxpMG-s19dRcmov1iDxz-E --recipient "${recipient}" --data @"/data/oor-auth-data.json" --edges @"/data/oor-auth-edge-data.json" --rules @"/data/rules.json" --out "/data/credential.json"
